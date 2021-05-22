# import spacy

# nlp = spacy.load("en_core_web_sm")
# doc = nlp("San Francisco considers banning delivery services")
# print(doc.ents)



# def read_article():
#     file = open('litreview.txt', "r")
#     print(file)
    # filedata = file.readlines()
    # article = filedata[0].split(". ")
    
#     sentences = []

#     for sentence in article:
#         print(sentence)
#         sentences.append(sentence.replace("[^a-zA-Z]", " ").split(" "))
#     sentences.pop()
#     # print(sentences)
#     return sentences

#     read_article()

print('hello')
file = open('litreview.txt', "r")
filedata = "While AI is at looked as futuristic and a technology far away from realization, we are living inthe modern ages and its applications are becoming more demanding than ever. New trendsemerge and all of these are driven by increase in data, this increases in data spikes new ways ofmodeling this information to get the best out of it. One of the interesting and fascinating trends inAI is Conversational Artificial Intelligence. This technology offers operational efficiency andbrings cost savings to businesses and institutions while offering convenience and added servicesfor users. End users interact with these chatbot systems through their smartphones, dedicated devices like The Apple homepod, Amazon Alexa among others. These systems have fused in ourecosystem and now interaction feels more natural that is, and users communicate by text and voice to leverage on such platforms to simplify their daily tasks like booking a bus, hotel reservation, banking, receiving self-healthcare services, among others. These personal virtual assistants are becoming an integral part of our lives.How do they work There are stable individual differences in human speech and writing behaviors patterns. A computer is unable to understand human speech as we people do. We humans do a better job at conversations. So, one of the tasks is to teach a computer how people converse. Thus, enters the usefulness of natural language processing techniques, which can extract a variety of features present in speech and writing. A series of observations in text that are stable over time but different between individuals may then correlate closely with a personality trait or traits. Forexample, researchers have found correlations between the results of thoroughly tested personality assessment questionnaires and a variety of features such as function words (such as prepositions) and other English grammatical structures. However, when automating using NLP, the focus hasbeen on word counts, n-grams, and sometimes part of speech. A few tools, which we enumerateas they appear in the literature, have arisen to facilitate the extraction of such features. The first step to building a successful contextual assistant is planning the types of conversations your assistant will be able to have, a process known as conversation design. Conversation designshould start with three important planning steps to ensure your assistant will meet the needs ofyour users: 1.Asking who your users are 2.Understanding the assistant’s purpose 3.Documenting the most typical conversations users will have with the assistant After addressing these questions, we can then generate possible questions that we expect users toask our system. We draft a set of training data and label intents and entities and design theconversation flow - patterns we can use to identify common intents our assistant should anticipate.The proceeding series of steps involve Machine Learning to extract meaning from text input,sequence of processing steps which allow the model to learn the training data’s underlying patterns so to enable the bot to develop a mapping of new conversations it has not seen before.There exits preconfigured pipelines and libraries for intent classification and entity extraction,for example Pretrained_embeddings_spacy1 and Supervised_embeddings.2 In the recent years, there has been evolvements of platforms and tools to give developers told forcreating AI bot systems. Among these include 1.Dialogflow is a natural language understanding platform used to design and integrate a conversational user interface into mobile apps, web applications, devices, bots, interactive voiceresponse systems and related uses.This is a good start for the project though offers the Standard Edition is free, but with limits onthe amount of requests that you can make. This is why we got interested in the other alternative Rasa 2. Rasa - Rasa Enterprise is the company's commercial offering, providing an enterprise-gradeplatform for developing contextual assistants at scale. It supplies the standard infrastructure forconversational AI, providing the tools required to build better, more resilient contextualassistants. With more than 3 million downloads since launch, Rasa Open Source is the mostpopular open-source software in conversational AI. For this project, we shall be using the Rasatechnologies to build our systemOn the market scene there are some AI chatbots like the Google Assistant, Siri, Amazon Alexa,Cortana, Replika that do amazing tasks everyday like translations, checking email, settingreminders, checking the weather, among others. However, from an investigation we haveconducted, our user base has more specific problems that these systems fail to address which iswhy we are building Leren. Leren will be custom tailored for our target users to handle specificrequests like downloading course material, providing emotional support to students, data loggingfor users who require special attention for example students seeking emergency help, counsellingservices, providing information about the University, colleges, hostels, among others.Therefore, the purpose of this study is to test, improve and build an AI powered system to betterinformation delivery and processing to students through a mobile application.\n"
article = filedata.split(". ")
print(article)
sentences = []
for sentence in article:        
        sentences.append(sentence.replace("[^a-zA-Z]", " ").split(" "))
sentences.pop() 
print(sentences)