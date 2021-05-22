# This files contains your custom actions which can be used to run
# custom Python code.

# See this guide on how to implement these action:
# https://rasa.com/docs/rasa/custom-actions


# This is a simple example for a custom action which utters "Hello World!"

from typing import Any, Text, Dict, List

from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import SlotSet
from rasa_sdk.knowledge_base.storage import InMemoryKnowledgeBase
from rasa_sdk.knowledge_base.actions import ActionQueryKnowledgeBase
from rasa_sdk.forms import FormAction, REQUESTED_SLOT
from rasa_sdk import utils
import nltk
from nltk.corpus import stopwords
from nltk.cluster.util import cosine_distance
import numpy as np
import networkx as nx
from datetime import datetime, date
from actions.weather import Weather
from actions.summarizer import generate_summary


class SearchLocation(Action):

    def name(self) -> Text:
        return "search_location"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        dispatcher.utter_message(text="Hello World!")

        return []


class TellTime(Action):

    def name(self) -> Text:
        return "action_tell_time"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        now = datetime.now()

        
        current_time = now.strftime("%H:%M")
        dispatcher.utter_message(text=f"It is {current_time}")

        return []


class TellDate(Action):

    def name(self) -> Text:
        return "action_tell_date"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        today = date.today()

        current_date = today.strftime("%d/%m/%Y")
        dispatcher.utter_message(text=f"Today is, {current_date}")

        return []


class WeatherClass(Action):

    def name(self) -> Text:
        return "action_weather_api"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        
        temp = Weather()     
        
        dispatcher.utter_message(text=f"{temp}")
        
        return []


class EssayForm(FormAction):

    def name(self):
        return "essay_form"

    def required_slot(tracker: Tracker) -> List[Text]:
        return ["essaybody"]

    def slot_mappings(self):
        return {"essaybody": [self.from_text()]}

    def submit(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict]:
        dispatcher.utter_message(text=f"Okay, a moment")


class TextSummarizer(Action):

    def name(self) -> Text:
        return "action_summarize_text"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        
        slot_value = tracker.get_slot('essaybody')
        if len(slot_value) > 30:
            data = (generate_summary(str(slot_value), 2))
            dispatcher.utter_message(text=f"The summarized text is\n\n{data}")
        else:
            dispatcher.utter_message(text=f"Oops, Your essay is too short")                

        return [SlotSet("essaybody", None)]


class ActionSearchConcerts(Action):
    def name(self):
        return "action_search_concerts"

    def run(self, dispatcher, tracker, domain):
        concerts = [
            {"artist": "Foo Fighters", "reviews": 4.5},
            {"artist": "Katy Perry", "reviews": 5.0},
        ]
        description = ", ".join([c["artist"] for c in concerts])
        dispatcher.utter_message(text=f"{description}")
        return [SlotSet("concerts", concerts)]


class ActionSearchVenues(Action):
    def name(self):
        return "action_search_venues"

    def run(self, dispatcher, tracker, domain):
        venues = [
            {"name": "Big Arena", "reviews": 4.5},
            {"name": "Rock Cellar", "reviews": 5.0},
        ]
        dispatcher.utter_message(text="here are some venues I found")
        description = ", ".join([c["name"] for c in venues])
        dispatcher.utter_message(text=f"{description}")
        return [SlotSet("venues", venues)]


class ActionMyKB(ActionQueryKnowledgeBase):
    def __init__(self):
        # load knowledge base with data from the given file
        knowledge_base = InMemoryKnowledgeBase("knowledge_base_data.json")

        # overwrite the representation function of the hotel object
        # by default the representation function is just the name of the object
        knowledge_base.set_representation_function_of_object(
            "hostel", lambda obj: obj["name"]
        )
        knowledge_base.set_representation_function_of_object(
            "restaurant", lambda obj: obj["name"] + " -- " + obj["meal"]
        )
        knowledge_base.set_representation_function_of_object(
            "college", lambda obj: obj["name"]
        )
        knowledge_base.set_representation_function_of_object(
            "halls", lambda obj: obj["name"] + " -- " + obj["gender"]
        )
        knowledge_base.set_representation_function_of_object(
            "lecturers", lambda obj: obj["name"] 
        )

        super().__init__(knowledge_base)

    def utter_attribute_value(
        self,
        dispatcher: CollectingDispatcher,
        object_name: Text,
        attribute_name: Text,
        attribute_value: Text,
    ):
        """
        Utters a response that informs the user about the attribute value of the
        attribute of interest.

        Args:
            dispatcher: the dispatcher
            object_name: the name of the object
            attribute_name: the name of the attribute
            attribute_value: the value of the attribute
        """

        answer = "Yes" if attribute_value else "No"
        if attribute_value:
            if attribute_name == 'price-range':
                dispatcher.utter_message(
                    text=f"Hostel price range for {object_name} is {attribute_value}."
                )
            if attribute_name == 'transport-shuttle':
                dispatcher.utter_message(
                    text=f"{answer}, {object_name} has a shuttle."
                )
            if attribute_name == 'free-wifi':
                dispatcher.utter_message(
                    text=f"{answer}, {object_name} has WIFI access."
                )
            if attribute_name == 'area':
                dispatcher.utter_message(
                    text=f"{object_name} is found around {attribute_value}."
                )
            if attribute_name == 'about-info':
                dispatcher.utter_message(
                    text=f"Here's what I know about {object_name}....{attribute_value}."
                )
            if attribute_name == 'courses':
                dispatcher.utter_message(
                    text=f"{object_name} has the following courses\n{attribute_value}."
                )
            if attribute_name == 'schools':
                dispatcher.utter_message(
                    text=f"{object_name} is formed up by these schools\n{attribute_value}."
                )
            if attribute_name == 'star-rating':
                dispatcher.utter_message(
                    text=f"{object_name} is rated {attribute_value}."
                )
                # for colleges
            if attribute_name == 'email':
                dispatcher.utter_message(
                    text=f"{object_name}'s email address is {attribute_value}."
                )
            if attribute_name == 'phone':
                dispatcher.utter_message(
                    text=f"{object_name}'s phone number is {attribute_value}."
                )
            if attribute_name == 'office-hours':
                dispatcher.utter_message(
                    text=f"Office hours for {object_name} is {attribute_value}."
                )
        else:
            dispatcher.utter_message(
                text=f"{answer}, {object_name} does not have {attribute_name}."
            )

    async def utter_objects(
        self,
        dispatcher: CollectingDispatcher,
        object_type: Text,
        objects: List[Dict[Text, Any]],
    ):
        """
        Utters a response to the user that lists all found objects.

        Args:
            dispatcher: the dispatcher
            object_type: the object type
            objects: the list of objects
        """
        if objects:
            dispatcher.utter_message(
                text=f"Here are some top results for {object_type};"
            )

            repr_function = await utils.call_potential_coroutine(
                self.knowledge_base.get_representation_function_of_object(
                    object_type)
            )

            for i, obj in enumerate(objects, 1):
                dispatcher.utter_message(text=f"{i}: {repr_function(obj)}")
        else:
            dispatcher.utter_message(
                text=f"Sorry, I can't find any close matches. Check your spelling for {object_type} or rephrase."
            )
