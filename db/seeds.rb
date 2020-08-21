Conversation.destroy_all
Account.destroy_all
Friend.destroy_all

acc1 = Account.create(username: 'Hagrid')
acc2 = Account.create(username: 'Luna')
acc3 = Account.create(username: 'Hedwig')
acc4 = Account.create(username: 'Draco')

friend1 = Friend.create(name: 'Harry', occupation: 'Wizard')
friend2 = Friend.create(name: 'Neville', occupation: 'Botanist')
friend3 = Friend.create(name: 'Ron', occupation: 'Personal Chef')
friend4 = Friend.create(name: 'Hermione', occupation: 'Professor')
friend5 = Friend.create(name: 'Cho', occupation: 'Dentist')
friend6 = Friend.create(name: 'Voldemort 💀 ', occupation: 'Antagonist')

convo1 = Conversation.create(account_id: acc1.id, friend_id: friend1.id, date: '2020-08-03')
convo2 = Conversation.create(account_id: acc1.id, friend_id: friend2.id, date: '2020-08-04')
convo3 = Conversation.create(account_id: acc1.id, friend_id: friend3.id, date: '2020-08-03')
convo4 = Conversation.create(account_id: acc2.id, friend_id: friend5.id, date: '2020-08-03')
convo5 = Conversation.create(account_id: acc2.id, friend_id: friend6.id, date: '2020-08-03') 
convo6 = Conversation.create(account_id: acc4.id, friend_id: friend6.id, date: '2018-09-10')
