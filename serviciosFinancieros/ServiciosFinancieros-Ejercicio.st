!classDefinition: #PortfolioTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'testing' stamp: 'fs 5/10/2024 13:48:02'!
test01_AnEmptyPortfolioHas0Balance
	|emptyPortfolio|
	
	emptyPortfolio := Portfolio new.
		
	self assert: (emptyPortfolio hasBalance: 0 * peso).! !

!PortfolioTest methodsFor: 'testing' stamp: 'fs 5/3/2024 17:50:40'!
test02_PortfolioWithASingleAccountCalculatesTheBalanceCorrectly
	|portfolio clientAccount|
	
	portfolio := Portfolio new.
	clientAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: clientAccount.
	
	portfolio add: clientAccount.
	
	self assert: (portfolio hasBalance: 100 * peso).! !

!PortfolioTest methodsFor: 'testing' stamp: 'fs 5/10/2024 13:50:02'!
test03_PortfolioWithTwoAccountsCalculatesTheBalanceCorrectly
	| aPortfolio accountWithDeposit accountWithWithdrawl |
	
	aPortfolio := Portfolio new.
	accountWithDeposit := ReceptiveAccount new.
	accountWithWithdrawl := ReceptiveAccount new.
	Deposit register: 500 * peso on: accountWithDeposit.
	Withdraw register: 80 * peso on: accountWithWithdrawl.
	
	aPortfolio addAll: {accountWithDeposit. accountWithWithdrawl}.
	
	self assert: (aPortfolio hasBalance: 420 * peso).! !

!PortfolioTest methodsFor: 'testing' stamp: 'fs 5/10/2024 13:57:32'!
test04_PortfoliosInPortfolioCalculatesTheBalanceCorrectly
	|aPortfolio childPortfolioWithADeposit childPortfolioWithAWithdrawl accountWithADeposit accountWithAWithdrawl|
	
	aPortfolio := Portfolio new.
	childPortfolioWithADeposit := Portfolio new.
	childPortfolioWithAWithdrawl := Portfolio new.
	
	accountWithADeposit := ReceptiveAccount new.
	accountWithAWithdrawl := ReceptiveAccount new.
	Deposit register: 500 * peso on: accountWithADeposit.
	Withdraw register: 80 * peso on: accountWithAWithdrawl.
	
	childPortfolioWithADeposit add: accountWithADeposit.
	childPortfolioWithAWithdrawl add: accountWithAWithdrawl.
	
	aPortfolio addAll: {childPortfolioWithADeposit. childPortfolioWithAWithdrawl}.
	
	self assert: (aPortfolio hasBalance: 420 * peso).! !

!PortfolioTest methodsFor: 'testing' stamp: 'fs 5/10/2024 14:00:57'!
test05_PortfolioWithAccountsAndPortfoliosCalculatesTheBalanceCorrectly
	|aPortfolio childPortfolioWithADeposit childPortfolioWithWithdrawl accountWithDeposit accountWithWithdrawl accountWithDepositStoredInRootPortfolio|
	
	aPortfolio := Portfolio new.
	childPortfolioWithADeposit := Portfolio new.
	childPortfolioWithWithdrawl := Portfolio new.
	
	accountWithDeposit := ReceptiveAccount new.
	accountWithWithdrawl := ReceptiveAccount new.
	accountWithDepositStoredInRootPortfolio := ReceptiveAccount new.
	
	Deposit register: 400 * peso on: accountWithDeposit.
	Withdraw register: 80 * peso on: accountWithWithdrawl.
	Deposit register: 100 * peso on: accountWithDepositStoredInRootPortfolio.
	
	childPortfolioWithADeposit add: accountWithDeposit.
	childPortfolioWithWithdrawl add: accountWithWithdrawl.
	aPortfolio addAll: {childPortfolioWithADeposit. childPortfolioWithWithdrawl. accountWithDepositStoredInRootPortfolio}.
	
	self assert: (aPortfolio hasBalance: 420 * peso).! !

!PortfolioTest methodsFor: 'testing' stamp: 'fs 5/10/2024 14:38:29'!
test06_PortfolioWithAclientWithATransactionKnowsThatTransaction
	|aPortfolio clientAccountWithTransaction aDeposit |
	
	aPortfolio := Portfolio new.	
	clientAccountWithTransaction := ReceptiveAccount new.
	
	aDeposit := Deposit register: 100 * peso on: clientAccountWithTransaction.

	aPortfolio add: clientAccountWithTransaction.

	self assert: (aPortfolio hasRegistered: aDeposit).
! !

!PortfolioTest methodsFor: 'testing' stamp: 'fs 5/10/2024 14:36:31'!
test07_PortfolioWithNoTransactionsReturnsAnEmptyCollectionWhenAskedForItsTransactions
	|anEmptyPortfolio|
	
	anEmptyPortfolio := Portfolio new.
	
	self assert: anEmptyPortfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'testing' stamp: 'fs 5/10/2024 14:56:22'!
test08_PortfolioWithAccountWithMultipleTransactionsKnowsThoseTransactions
	|aPortfolio aReceptiveAccount aDeposit aWithdrawl|
	
	aPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	aDeposit := Deposit register: 100 * peso on: aReceptiveAccount.
	aWithdrawl := Withdraw register: 200 * peso on: aReceptiveAccount.
	
	aPortfolio add: aReceptiveAccount.
	
	self assert: (aPortfolio hasRegistered: aDeposit).
	self assert: (aPortfolio hasRegistered: aWithdrawl).
	self assert: 2 equals: (aPortfolio transactions size).! !


!PortfolioTest methodsFor: 'validity' stamp: 'MB 5/4/2024 14:32:55'!
integrationTest
	|a b c d e f|
	"
	Esto no es TDD pero quisimos hacer un ejemplo un poquito mas comlpejo del test 13 :)
	
				    a         c
				  /   |      /   \
				f     b   d    e
				                /
				              b
	"

	a := Portfolio new.
	b := ReceptiveAccount new.
	c := Portfolio new.
	d := ReceptiveAccount new.
	e := Portfolio new.
	f := ReceptiveAccount new.
	
	a addAll: {b. f}.
	e add: b.
	c addAll: {d. e}.
	
	self 
	should: [a add: c]
	raise: Error
	withExceptionDo: [:anError | self assert: Portfolio portfolioWithAlreadyContainedAccount equals: anError messageText].
! !

!PortfolioTest methodsFor: 'validity' stamp: 'fs 5/10/2024 14:45:55'!
test09_APortfolioCantAddTheSameAccountTwice
	|aPortfolio aReceptiveAccount|
	
	aPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.

	aPortfolio add: aReceptiveAccount.
	
	self 
	should: [aPortfolio add: aReceptiveAccount] 
	raise: Error
	withExceptionDo: [:anError | self assert: Portfolio alreadyContainedAccount equals: anError messageText].! !

!PortfolioTest methodsFor: 'validity' stamp: 'fs 5/10/2024 14:50:08'!
test10_APortfolioCantAddAnAccountContainedInASubPortfolio
	|aPortfolio aSubPortfolio aReceptiveAccount|
	
	aPortfolio := Portfolio new.
	aSubPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	aSubPortfolio add: aReceptiveAccount.
	aPortfolio add: aSubPortfolio.
	
	self 
	should: [aPortfolio add: aReceptiveAccount] 
	raise: Error
	withExceptionDo: [:anError | self assert: Portfolio alreadyContainedAccount equals: anError messageText].! !

!PortfolioTest methodsFor: 'validity' stamp: 'fs 5/10/2024 14:49:52'!
test11_APortfolioCantAddItself
	|aPortfolio aSubPortfolio|
	
	aPortfolio := Portfolio new.
	aSubPortfolio := aPortfolio.
	
	self 
	should: [aPortfolio add: aSubPortfolio] 
	raise: Error
	withExceptionDo: [:anError | self assert: Portfolio selfContained equals: anError messageText].! !

!PortfolioTest methodsFor: 'validity' stamp: 'fs 5/10/2024 14:48:48'!
test12_APortfolioCantBeAddedToAPortfolioWhoseContainedElsewhereInAParentTree
	|aPortfolio subPortfolio aReceptiveAccount|
	
	aPortfolio := Portfolio new.
	subPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	aPortfolio add: subPortfolio.
	aPortfolio add: aReceptiveAccount.
	
	self 
	should: [subPortfolio add: aReceptiveAccount] 
	raise: Error
	withExceptionDo: [:anError | self assert: Portfolio alreadyContainedAccount equals: anError messageText].! !

!PortfolioTest methodsFor: 'validity' stamp: 'fs 5/10/2024 14:49:07'!
test13_APortfolioCantAddAnotherPortfolioWithaAnAlreadyContainedAccount
	|aPortfolio subPortfolio aReceptiveAccount|
	
	aPortfolio := Portfolio new.
	subPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	aPortfolio add: aReceptiveAccount.
	subPortfolio add: aReceptiveAccount.
	
	self 
	should: [aPortfolio add: subPortfolio] 
	raise: Error
	withExceptionDo: [:anError | self assert: Portfolio portfolioWithAlreadyContainedAccount equals: anError messageText].! !


!classDefinition: #ReceptiveAccountTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fs 5/10/2024 14:52:25'!
test01_ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.

	self assert: 0 equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fs 5/10/2024 14:52:30'!
test02_DepositIncreasesBalanceOnTransactionValue 

	| receptiveAccount |
	
	receptiveAccount := ReceptiveAccount  new.
	Deposit register: 100 * peso on: receptiveAccount.
		
	self assert: 100 * peso equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fs 5/10/2024 14:52:35'!
test03_WithdrawDecreasesBalanceOnTransactionValue 

	| receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: receptiveAccount.
	Withdraw register: 50 * peso on: receptiveAccount.
		
	self assert: 50 * peso equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fs 5/10/2024 14:52:40'!
test04_WithdrawValueMustBePositive 

	| receptiveAccount withdrawValue |
	
	receptiveAccount := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: receptiveAccount) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fs 5/10/2024 14:52:45'!
test05_ReceptiveAccountKnowsRegisteredTransactions 

	| receptiveAccount deposit withdraw |
	
	receptiveAccount := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: receptiveAccount.
	withdraw := Withdraw register: 50 * peso on: receptiveAccount.
		
	self assert: (receptiveAccount hasRegistered: deposit).
	self assert: (receptiveAccount hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fs 5/10/2024 14:52:50'!
test06_ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| receptiveAccount deposit withdraw |
	
	receptiveAccount := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (receptiveAccount hasRegistered: deposit).
	self deny: (receptiveAccount hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fs 5/10/2024 14:52:55'!
test07_AccountKnowsItsTransactions 

	| receptiveAccount deposit |
	
	receptiveAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: receptiveAccount.
		
	self assert: 1 equals: receptiveAccount transactions size.
	self assert: receptiveAccount transactions includes: deposit.
! !


!classDefinition: #ReportTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:24:32'!
test_07_anEmptyAccountGeneratesAnEmptySummaryWithBalanceOfCeroPesos
	|anEmptyAccount accountSummaryReport accountSummaryGenerator|
	
	anEmptyAccount := ReceptiveAccount new.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: anEmptyAccount.

	self assert: accountSummaryGenerator generateReport  = {'Balance = 0 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:24:55'!
test_08_anAccountWithOneDepositGeneratesASummaryWithOnlyOneDepositAndWithACorrectBalance
	| anAccount accountSummaryGenerator |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: anAccount.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: anAccount.
	
	self assert: accountSummaryGenerator generateReport = {'Deposito por 100 * pesos'.'Balance = 100 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:25:52'!
test_09_anAccountWithOneWithdrwalGeneratesASummaryWithOnlyOneWithdrawlAndCorrectBalance
	|anAccount accountSummaryGenerator |
	
	anAccount := ReceptiveAccount new.
	
	Withdraw register: 100 * peso on: anAccount.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: anAccount.
	
	self assert: accountSummaryGenerator generateReport = {'Extraccion por 100 * pesos'.'Balance = -100 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:26:15'!
test_10_anAccountWithOneTransferDepositGeneratesASummaryWithOnlyOneTransferDepositAndCorrectBalance
	| receiverAccount senderAccount accountSummaryGenerator |
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: senderAccount.
	
	self assert: accountSummaryGenerator generateReport = {'Salida por transferencia de 100 * pesos'.'Balance = -100 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:26:35'!
test_11_anAccountWithOneTransferWithdrawlGeneratesASummaryWithOnlyOneTransferWithdrawlAndCorrectBalance
	| receiverAccount senderAccount accountSummaryGenerator |
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: receiverAccount.
	
	self assert: accountSummaryGenerator generateReport = {'Entrada por transferencia de 100 * pesos'.'Balance = 100 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:27:24'!
test_12_anAccountWithADepositAndTransferDepositGeneratesASummaryWithDepositTransferDepositAndCorrectBalance
	|receiverAccount senderAccount accountSummaryGenerator |
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: receiverAccount.
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.

	accountSummaryGenerator := AccountSummaryGenerator newFor: receiverAccount.
		
	self assert: accountSummaryGenerator generateReport = {'Deposito por 50 * pesos'.'Entrada por transferencia de 100 * pesos'.'Balance = 150 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:28:16'!
test_13_anEmptyPortfolioGeneratesAnEmptySummaryWithBalanceOfCeroPesos
	|aPortfolio accountSummaryGenerator|

	aPortfolio := Portfolio new.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: aPortfolio.
	
	self assert: accountSummaryGenerator generateReport = {'Balance = 0 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:28:32'!
test_14_aPortfolioWithAnAccountWithADepositAndTransferDepositGeneratesASummaryWithADepositTRansferDepositAndCorrectBalance
	| aPortfolio receiverAccount senderAccount accountSummaryGenerator|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: receiverAccount.
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio add: receiverAccount.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: aPortfolio.
	
	self assert: accountSummaryGenerator generateReport = {'Deposito por 50 * pesos'.'Entrada por transferencia de 100 * pesos'.'Balance = 150 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:29:49'!
test_15_aPortfolioWithAnAccountWithAWithrdawlAndTransferWithdrawlGeneratesASummaryWithAWithdrawlTRansferWithdrawlAndCorrectBalance
	| aPortfolio receiverAccount senderAccount accountSummaryGenerator|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	Withdraw register: 50 * peso on: senderAccount.
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio add: senderAccount.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: aPortfolio.
	
	self assert: accountSummaryGenerator generateReport = {'Extraccion por 50 * pesos'.'Salida por transferencia de 100 * pesos'.'Balance = -150 * pesos'} asOrderedCollection.
! !

!ReportTest methodsFor: 'Account summary report tests' stamp: 'fs 5/9/2024 12:30:15'!
test_16_aPortfolioWithTwoAccountWithBasicTransactionsAndTransferTransactionsGenerateASummaryWithTheirRespectiveTransactionsAndCorrectBalance
	| aPortfolio receiverAccount senderAccount accountSummaryGenerator |
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	Withdraw register: 50 * peso on: senderAccount.
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio addAll: {receiverAccount. senderAccount}.
	
	accountSummaryGenerator := AccountSummaryGenerator newFor: aPortfolio.
	
	self assert: accountSummaryGenerator generateReport = {'Entrada por transferencia de 100 * pesos'.'Extraccion por 50 * pesos'.'Salida por transferencia de 100 * pesos'.'Balance = -50 * pesos'} asOrderedCollection.
! !


!ReportTest methodsFor: 'Net Transfer report tests' stamp: 'fs 5/9/2024 12:55:17'!
test_00_anEmptyReceptiveAccountGeneratesANetTransferReportOfZeroPesos
	| anEmptyAccount netTransferCalculator |

	anEmptyAccount := ReceptiveAccount new.
	
	netTransferCalculator := NetTransferCalculator newFor: anEmptyAccount.
	
	self assert: netTransferCalculator generateReport = (0 * peso).
! !

!ReportTest methodsFor: 'Net Transfer report tests' stamp: 'fs 5/9/2024 12:54:56'!
test_01_theNetTransferForAReceptiveAccountWithATransferDepositIsCorrect
	| senderAccount receiverAccount receiverNettransferCalculator |

	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	receiverNettransferCalculator := NetTransferCalculator newFor: receiverAccount.
	
	self assert: receiverNettransferCalculator generateReport = (100 * peso).! !

!ReportTest methodsFor: 'Net Transfer report tests' stamp: 'fs 5/9/2024 12:55:05'!
test_02_theNetTransferForAReceptiveAccountWithATransferWithdrawlIsCorrect
	| senderAccount receiverAccount senderNetTransferCalculator |

	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	senderNetTransferCalculator := NetTransferCalculator newFor: senderAccount.
	
	self assert: senderNetTransferCalculator generateReport = (-100 * peso).! !

!ReportTest methodsFor: 'Net Transfer report tests' stamp: 'fs 5/10/2024 13:39:00'!
test_03_anEmptyPortfolioGeneratesANetTransferReportOfZeroPesos
	| anEmptyPortfolio netTransferCalculator |
	
	anEmptyPortfolio := Portfolio new.
	
	netTransferCalculator := NetTransferCalculator newFor: anEmptyPortfolio.
	
	self assert: netTransferCalculator generateReport = (0 * peso).
! !

!ReportTest methodsFor: 'Net Transfer report tests' stamp: 'fs 5/9/2024 12:54:20'!
test_04_theNetTransferForAPorfolioWithAReceptiveAccountWithATransferWithdrawlIsCorrect
	| aPortfolio senderAccount receiverAccount portfolioNetTransferCalculator |

	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio add: senderAccount.
	
	portfolioNetTransferCalculator := NetTransferCalculator newFor: aPortfolio.
	
	self assert: portfolioNetTransferCalculator generateReport = (-100 * peso).
! !

!ReportTest methodsFor: 'Net Transfer report tests' stamp: 'fs 5/9/2024 12:57:08'!
test_05_theNetTransferForAPorfolioWithAReceptiveAccountWithATransferDepositIsCorrect
	| aPortfolio senderAccount receiverAccount portfolioNetTransferCalculator |

	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio add: receiverAccount.
	
	portfolioNetTransferCalculator := NetTransferCalculator newFor: aPortfolio.
	
	self assert: portfolioNetTransferCalculator generateReport = (100 * peso).
! !

!ReportTest methodsFor: 'Net Transfer report tests' stamp: 'fs 5/9/2024 12:58:57'!
test_06_theNetTransferForAPortfolioWithMultipleReceptiveAccountsWithTransfersIsCorrect
	| aPortfolio senderAccount receiverAccount portfolioNetTransferCalculator |

	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio addAll: {receiverAccount. senderAccount}.
	
	portfolioNetTransferCalculator := NetTransferCalculator newFor: aPortfolio.
	
	self assert: portfolioNetTransferCalculator generateReport = (0 * peso).
! !


!classDefinition: #TransferTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'transfers' stamp: 'MB 5/4/2024 14:48:38'!
test01_TransferingMoneyAffectsTheReceptiveAccountsBalances
	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: senderAccount.
	
	Transfer register: 100 * peso from: senderAccount to: receiverAccount.
	
	self assert: (senderAccount hasBalance: 0 * peso).
	self assert: (receiverAccount hasBalance: 100 * peso).
	! !

!TransferTest methodsFor: 'transfers' stamp: 'MB 5/4/2024 14:47:20'!
test02_EachLegOfTheTransferKnowsItsCounterpart
	| senderAccount receiverAccount transfer|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer register: 100 * peso from: senderAccount  to: receiverAccount.
	
	self assert: transfer depositLeg counterpart equals: transfer withdrawlLeg.
	self assert: transfer withdrawlLeg counterpart equals: transfer depositLeg.! !

!TransferTest methodsFor: 'transfers' stamp: 'MB 5/4/2024 14:46:30'!
test03_ATransferKnowsTheAmountOfMoneyTransfered
	| senderAccount receiverAccount transfer|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer register: 100 * peso from: senderAccount  to: receiverAccount.
	
	self assert: (transfer amountIs: 100 * peso).! !

!TransferTest methodsFor: 'transfers' stamp: 'MB 5/4/2024 14:44:57'!
test04_TransferingANegativeAmountOfMoneyThrowsAnError
	| senderAccount receiverAccount|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	self should: [Transfer register:  -100 * peso from: senderAccount  to: receiverAccount.]
	raise: Error
	withExceptionDo: [:anError | self assert: Transfer invalidNegativeAmount equals: anError messageText].! !

!TransferTest methodsFor: 'transfers' stamp: 'MB 5/4/2024 14:40:46'!
test05_Transfering0PesosIsInvalidAndThrowsAnError
	| senderAccount receiverAccount|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	self should: [Transfer register:  0 * peso from: senderAccount  to: receiverAccount.]
	raise: Error
	withExceptionDo: [:anError | self assert: Transfer invalidZeroAmount equals: anError messageText].! !

!TransferTest methodsFor: 'transfers' stamp: 'MB 5/4/2024 14:39:18'!
test06_TransferingMoneyToItselfThrowsAnError
	| senderAccount|
	
	senderAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: senderAccount.
	
	self should: [Transfer register:  100 * peso from: senderAccount  to: senderAccount.]
	raise: Error
	withExceptionDo: [:anError | self assert: Transfer cannotSelfTransfer equals: anError messageText].! !


!classDefinition: #Account category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'main protocol' stamp: 'fs 5/7/2024 20:23:50'!
accounts

	self subclassResponsibility! !

!Account methodsFor: 'main protocol' stamp: 'MB 5/4/2024 11:14:20'!
addParent: aParent
	self subclassResponsibility .
! !

!Account methodsFor: 'main protocol' stamp: 'fs 5/3/2024 19:49:23'!
balance
	self subclassResponsibility .! !

!Account methodsFor: 'main protocol' stamp: 'fs 5/3/2024 19:50:06'!
has: anAccount

	self subclassResponsibility! !

!Account methodsFor: 'main protocol' stamp: 'fs 5/3/2024 19:50:01'!
hasBalance: aBalance

	self subclassResponsibility! !

!Account methodsFor: 'main protocol' stamp: 'fs 5/3/2024 19:51:35'!
hasRegistered: aTransaction

	self subclassResponsibility! !


!Account methodsFor: 'transaction' stamp: 'fs 5/3/2024 19:50:32'!
transactions

	self subclassResponsibility! !


!Account methodsFor: 'account report' stamp: 'fs 5/9/2024 13:01:26'!
makeReport: aReport

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'account management' stamp: 'fs 5/7/2024 20:23:50'!
add: clientAccount
	| clientAccountAccounts |

	(self has: clientAccount) ifTrue: [
		^ self error: self class alreadyContainedAccount.
	].

	(self == clientAccount) ifTrue: [
		^ self error: self class selfContained.
	].

	(parents anySatisfy: [ :parent | parent parentHas: clientAccount sentBy: self]) ifTrue: [
		^ self error: self class alreadyContainedAccount.
	].

	clientAccountAccounts := clientAccount accounts.
	(self accounts anySatisfy: [ :anAccount |
		clientAccountAccounts includes: anAccount
	]) ifTrue: [
		^ self error: self class portfolioWithAlreadyContainedAccount.
	].

	accounts add: clientAccount.
	clientAccount addParent: self.! !

!Portfolio methodsFor: 'account management' stamp: 'fs 5/3/2024 17:50:06'!
addAll: accountCollection
	accountCollection do: [:anAccount | self add: anAccount].! !

!Portfolio methodsFor: 'account management' stamp: 'MB 5/4/2024 11:48:47'!
has: anAccount
	^ accounts anySatisfy: [ :portfolioAccount | portfolioAccount has: anAccount ].! !

!Portfolio methodsFor: 'account management' stamp: 'fs 5/3/2024 19:47:13'!
initialize
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'transaction' stamp: 'fs 5/3/2024 18:16:22'!
hasRegistered: aTransaction
	^ accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].
! !

!Portfolio methodsFor: 'transaction' stamp: 'fs 5/3/2024 19:00:35'!
transactions
	|totalTransactions|
	
	totalTransactions := OrderedCollection new.
	accounts do: [ :anAccount | 
		totalTransactions addAll: anAccount transactions.
	].

	^ totalTransactions.
! !


!Portfolio methodsFor: 'balance' stamp: 'MB 5/4/2024 11:29:09'!
balance
	accounts ifEmpty: [
		^ 0 * peso.
	].

	^ accounts sum: [ :account | account balance].! !

!Portfolio methodsFor: 'balance' stamp: 'fs 5/3/2024 17:39:13'!
hasBalance: aBalance 
	^ self balance = aBalance.! !


!Portfolio methodsFor: 'main protocol' stamp: 'fs 5/7/2024 20:23:50'!
accounts
	| totalAccounts |
	
	totalAccounts := OrderedCollection new.
	accounts do: [ :anAccount |
		totalAccounts addAll: anAccount accounts.
		totalAccounts add: anAccount.
	].
	
	^ totalAccounts.! !

!Portfolio methodsFor: 'main protocol' stamp: 'fs 5/3/2024 20:05:18'!
addParent: aParent
	parents add: aParent.! !

!Portfolio methodsFor: 'main protocol' stamp: 'MB 5/4/2024 11:05:01'!
parentHas: anAccount sentBy: aChild
	| filteredChildren |
	
	filteredChildren := accounts select: [ :childAccount | (childAccount = aChild) not].	
	(filteredChildren anySatisfy: [ :childAccount | childAccount has: anAccount]) ifTrue: [
		^ self error: self class alreadyContainedAccount.
	].
	
	(self == anAccount) ifTrue: [
		^ self error: self class selfContained.
	].
	
	(parents anySatisfy: [ :parent | parent parentHas: anAccount sentBy: self ]) ifTrue: [
		^ self error: self class alreadyContainedAccount.
	].

	^ false.! !


!Portfolio methodsFor: 'account report' stamp: 'fs 5/9/2024 10:52:37'!
makeReport: aReport
	accounts do: [:aChildAccount |
		aChildAccount makeReport: aReport.		
	].
	aReport portfolioReport: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'MB 5/4/2024 11:09:48'!
alreadyContainedAccount
	^ 'The account is already contained in this portfolio'! !

!Portfolio class methodsFor: 'error' stamp: 'MB 5/4/2024 11:10:19'!
portfolioWithAlreadyContainedAccount
	^ 'The subportfolio cant have an account already contained in the parent portfolio'.! !

!Portfolio class methodsFor: 'error' stamp: 'fs 5/3/2024 19:34:36'!
selfContained
	^ 'A portfolio cant contain an instance of itself'.! !


!classDefinition: #ReceptiveAccount category: #'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions transferTransactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MB 5/4/2024 15:16:08'!
initialize

	transactions := OrderedCollection new.
	transferTransactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fs 5/7/2024 20:23:50'!
accounts
	"
	Esté método polimórfico está fundamentado de lo leído del paper de Composite.
	Abajo está el extracto en donde se explica este caso en particular del punto 3 en
	la sección de implementación.
	
	Sometimes a little creativity shows how an operation that would appear to
	make sense only for Composites can be implemented for all Components by
	moving it to the Component class. For example, the interface for accessing
	children is a fundamental part of a Composite class but not necessarily Leaf
	classes. But if we view a Leaf as a Component that never has children, then we
	can define a default operation for child access in the Component class that
	never returns any children. Leaf classes can use the default implementation,
	but Composite classes will reimplement it to return their children.
	"
	
	^ OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MB 5/4/2024 11:15:03'!
addParent: aParent
	"Un ReceptiveAccount no necesita guardar sus padres"! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fs 5/7/2024 20:41:08'!
balance
	|balance|
	balance := 0 * peso.
	transactions do: [ :aTransaction | balance := aTransaction addToBalance: balance  ].
	transferTransactions do: [ :aTransferTransaction | balance := aTransferTransaction addToBalance: balance ].
	^balance.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fs 5/3/2024 19:31:11'!
has: anAccount
	^ self = anAccount.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fs 4/30/2024 21:00:11'!
hasBalance: aBalance
	^ self balance  = aBalance.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MB 5/4/2024 15:22:17'!
hasRegistered: aTransaction

	^ (transactions, transferTransactions) includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MB 5/4/2024 15:19:56'!
registerAsTransfer: aTransferTransaction

	transferTransactions add: aTransferTransaction. 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MB 5/4/2024 15:15:40'!
transactions 
	^ transactions , transferTransactions.! !


!ReceptiveAccount methodsFor: 'report' stamp: 'MB 5/4/2024 15:26:43'!
netTransferBalance

	| balance |
	
	balance := 0.
	transferTransactions do: [ :aTransferTransaction | balance := aTransferTransaction addToBalance: balance ].
	^ balance.! !


!ReceptiveAccount methodsFor: 'account report' stamp: 'fs 5/9/2024 10:52:43'!
makeReport: aReport
	self transactions do: [:aTransaction |
		aTransaction makeReport: aReport.		
	].
	aReport receptiveAccountReport: self.! !


!classDefinition: #AccountTransaction category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'fs 5/7/2024 20:51:22'!
value

	^ value! !


!AccountTransaction methodsFor: 'balance' stamp: 'fs 4/30/2024 20:23:25'!
addToBalance: aBalance

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'transaction report' stamp: 'fs 5/9/2024 09:22:23'!
makeReport: aReport

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MB 5/4/2024 15:18:07'!
register: aValue on: account

	self subclassResponsibility! !


!classDefinition: #Deposit category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'transaction report' stamp: 'fs 5/8/2024 23:19:53'!
makeReport: aReport
	aReport registerDepositInReport: self.! !


!Deposit methodsFor: 'balance' stamp: 'fs 4/30/2024 20:23:55'!
addToBalance: aBalance
	^aBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'MB 5/4/2024 15:18:07'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferDeposit category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transferCounterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'initialize' stamp: 'fs 5/1/2024 17:03:54'!
initializeFor: aValue

	value := aValue ! !


!TransferDeposit methodsFor: 'transaction report' stamp: 'fs 5/9/2024 09:24:33'!
makeReport: aReport
	aReport registerTransferDepositInReport: self.! !


!TransferDeposit methodsFor: 'balance' stamp: 'fs 5/1/2024 17:04:38'!
addToBalance: aBalance
	^aBalance + value! !


!TransferDeposit methodsFor: 'main protocol' stamp: 'fs 5/1/2024 16:55:34'!
counterpart
	^transferCounterpart ! !


!TransferDeposit methodsFor: 'private' stamp: 'fs 5/1/2024 16:54:06'!
setCounterpart: aWhitdrawlLeg
	transferCounterpart := aWhitdrawlLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'fs 5/1/2024 17:01:18'!
for: aValue

	^ self new initializeFor: aValue ! !


!TransferDeposit class methodsFor: 'instance creation' stamp: 'MB 5/4/2024 15:18:56'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account registerAsTransfer: transaction.
		
	^ transaction! !


!classDefinition: #TransferWithdrawl category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferWithdrawl
	instanceVariableNames: 'transferCounterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdrawl methodsFor: 'transaction report' stamp: 'fs 5/9/2024 10:05:42'!
makeReport: aReport
	aReport registerTransferWithdrawInReport: self.! !


!TransferWithdrawl methodsFor: 'balance' stamp: 'fs 5/1/2024 17:04:29'!
addToBalance: aBalance
	^aBalance - value! !


!TransferWithdrawl methodsFor: 'private' stamp: 'fs 5/1/2024 16:54:36'!
setCounterpart: aDepositLeg
	transferCounterpart := aDepositLeg.! !


!TransferWithdrawl methodsFor: 'main protocol' stamp: 'fs 5/1/2024 16:55:43'!
counterpart
	^transferCounterpart ! !


!TransferWithdrawl methodsFor: 'initialize' stamp: 'fs 5/1/2024 17:03:50'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdrawl class' category: #'ServiciosFinancieros-Ejercicio'!
TransferWithdrawl class
	instanceVariableNames: ''!

!TransferWithdrawl class methodsFor: 'as yet unclassified' stamp: 'fs 5/1/2024 17:01:40'!
for: aValue

	^ self new initializeFor: aValue ! !


!TransferWithdrawl class methodsFor: 'instance creation' stamp: 'MB 5/4/2024 15:19:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account registerAsTransfer: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'transaction report' stamp: 'fs 5/9/2024 09:35:58'!
makeReport: aReport
	aReport registerWithdrawInReport: self.! !


!Withdraw methodsFor: 'balance' stamp: 'fs 4/30/2024 20:24:06'!
addToBalance: aBalance
	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'MB 5/4/2024 15:18:07'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Report methodsFor: 'accounts' stamp: 'fs 5/9/2024 12:32:48'!
portfolioReport: aPortfolio

	self subclassResponsibility! !

!Report methodsFor: 'accounts' stamp: 'fs 5/9/2024 12:32:43'!
receptiveAccountReport: aReceptiveAccount

	self subclassResponsibility! !


!Report methodsFor: 'report' stamp: 'fs 5/9/2024 12:32:56'!
generateReport

	self subclassResponsibility! !


!Report methodsFor: 'transactions' stamp: 'fs 5/9/2024 12:32:36'!
registerDepositInReport: aDeposit

	self subclassResponsibility! !

!Report methodsFor: 'transactions' stamp: 'fs 5/9/2024 12:32:31'!
registerTransferDepositInReport: aTransferDeposit

	self subclassResponsibility! !

!Report methodsFor: 'transactions' stamp: 'fs 5/9/2024 12:32:27'!
registerTransferWithdrawInReport: aTransferWithdraw

	self subclassResponsibility! !

!Report methodsFor: 'transactions' stamp: 'fs 5/9/2024 12:32:22'!
registerWithdrawInReport: aWithdraw

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'ServiciosFinancieros-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'fs 5/8/2024 16:45:54'!
accountSummary: anAccount
	|accountSummary partialAccountSummary partialTransactionSummary|
	
	(anAccount isKindOf: Portfolio) ifTrue: [
		accountSummary := OrderedCollection new.
		anAccount accounts do: [ :childAccount |
			partialAccountSummary := Report accountSummary: childAccount.
			partialAccountSummary removeLast.
			accountSummary addAll: partialAccountSummary.
		].

		accountSummary add: 'Balance = ', anAccount balance asString.
		^ accountSummary.
	].
	
	(anAccount isKindOf: ReceptiveAccount) ifTrue: [
	
		accountSummary := OrderedCollection new.
		anAccount transactions do: [ :aTransaction |
			(aTransaction isKindOf: Deposit) ifTrue: [
				partialTransactionSummary := 'Deposito por '.
			].
		
			(aTransaction isKindOf: Withdraw) ifTrue: [
				partialTransactionSummary := 'Extraccion por '.
			].		
		
			(aTransaction isKindOf: TransferWithdrawl) ifTrue: [
				partialTransactionSummary := 'Salida por transferencia de '.	
			].
			
			(aTransaction isKindOf: TransferDeposit) ifTrue: [
				partialTransactionSummary := 'Entrada por transferencia de '.
			].
		
			accountSummary add: partialTransactionSummary, aTransaction value asString.
		].

		partialTransactionSummary := 'Balance = ', anAccount balance asString.
		accountSummary add: partialTransactionSummary.
		^ accountSummary.	
	].
	
	
	! !

!Report class methodsFor: 'as yet unclassified' stamp: 'fs 5/8/2024 16:49:54'!
netTransferBalance: anAccount
	| balance |
	(anAccount isKindOf: Portfolio) ifTrue: [
		
		(anAccount accounts isEmpty) ifTrue: [
			^ 0 * peso.	
		].
		
		^ anAccount accounts sum: [ :childAccount |
			childAccount netTransferBalance.
		].
	].
	(anAccount isKindOf: ReceptiveAccount) ifTrue: [
		balance := 0.
		anAccount transactions do: [ :aTransferTransaction | balance := aTransferTransaction addToBalance: balance ].
		^ balance.
	].! !


!classDefinition: #AccountSummaryGenerator category: #'ServiciosFinancieros-Ejercicio'!
Report subclass: #AccountSummaryGenerator
	instanceVariableNames: 'reportLines account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummaryGenerator methodsFor: 'transactions' stamp: 'fs 5/9/2024 10:05:58'!
registerDepositInReport: aDeposit
	reportLines  add: 'Deposito por ', aDeposit value asString.! !

!AccountSummaryGenerator methodsFor: 'transactions' stamp: 'fs 5/9/2024 10:05:19'!
registerTransferDepositInReport: aTransferDeposit
	reportLines  add: 'Entrada por transferencia de ', aTransferDeposit value asString.! !

!AccountSummaryGenerator methodsFor: 'transactions' stamp: 'fs 5/9/2024 10:06:07'!
registerTransferWithdrawInReport: aTransferWithdraw
	reportLines add: 'Salida por transferencia de ', aTransferWithdraw value asString.! !

!AccountSummaryGenerator methodsFor: 'transactions' stamp: 'fs 5/9/2024 10:06:12'!
registerWithdrawInReport: aWithdraw
	reportLines  add: 'Extraccion por ', aWithdraw value asString.! !


!AccountSummaryGenerator methodsFor: 'report' stamp: 'fs 5/9/2024 11:01:10'!
generateReport
	account makeReport: self.
	
	reportLines add: 'Balance = ', account balance asString.
	
	^reportLines! !


!AccountSummaryGenerator methodsFor: 'accounts' stamp: 'fs 5/9/2024 10:59:14'!
portfolioReport: aPortfolio
	! !

!AccountSummaryGenerator methodsFor: 'accounts' stamp: 'fs 5/9/2024 10:59:21'!
receptiveAccountReport: aReceptiveAccount
	! !


!AccountSummaryGenerator methodsFor: 'initilize' stamp: 'fs 5/9/2024 10:57:48'!
initializeWith: anAccount
	account := anAccount.
	reportLines := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryGenerator class' category: #'ServiciosFinancieros-Ejercicio'!
AccountSummaryGenerator class
	instanceVariableNames: ''!

!AccountSummaryGenerator class methodsFor: 'as yet unclassified' stamp: 'fs 5/9/2024 11:00:21'!
newFor: anAccount
	
	^self new initializeWith: anAccount.
	

	! !


!classDefinition: #NetTransferCalculator category: #'ServiciosFinancieros-Ejercicio'!
Report subclass: #NetTransferCalculator
	instanceVariableNames: 'account netTransferTotal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!NetTransferCalculator methodsFor: 'transactions' stamp: 'fs 5/9/2024 12:33:08'!
registerDepositInReport: aDeposit
! !

!NetTransferCalculator methodsFor: 'transactions' stamp: 'fs 5/9/2024 12:34:58'!
registerTransferDepositInReport: aTransferDeposit
	netTransferTotal := aTransferDeposit addToBalance: netTransferTotal.! !

!NetTransferCalculator methodsFor: 'transactions' stamp: 'fs 5/9/2024 12:35:05'!
registerTransferWithdrawInReport: aTransferWithdraw
	netTransferTotal := aTransferWithdraw addToBalance: netTransferTotal.! !

!NetTransferCalculator methodsFor: 'transactions' stamp: 'fs 5/9/2024 12:35:15'!
registerWithdrawInReport: aWithdraw
! !


!NetTransferCalculator methodsFor: 'report' stamp: 'fs 5/9/2024 12:39:44'!
generateReport
	account makeReport: self.
	
	^netTransferTotal ! !


!NetTransferCalculator methodsFor: 'accounts' stamp: 'fs 5/9/2024 12:32:05'!
portfolioReport: aPortfolio
	! !

!NetTransferCalculator methodsFor: 'accounts' stamp: 'fs 5/9/2024 12:32:05'!
receptiveAccountReport: aReceptiveAccount
	! !


!NetTransferCalculator methodsFor: 'initilize' stamp: 'fs 5/9/2024 12:41:08'!
initializeWith: anAccount
	account := anAccount.
	netTransferTotal := 0 * peso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NetTransferCalculator class' category: #'ServiciosFinancieros-Ejercicio'!
NetTransferCalculator class
	instanceVariableNames: ''!

!NetTransferCalculator class methodsFor: 'as yet unclassified' stamp: 'fs 5/9/2024 12:32:05'!
newFor: anAccount
	
	^self new initializeWith: anAccount.
	

	! !


!classDefinition: #Transfer category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'depositLeg withdrawlLeg transferAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialize' stamp: 'fs 5/1/2024 16:51:42'!
initializeWith: aDepositLeg and: aWithdrawlLeg forAnAmount: anAmountOfPesos
	depositLeg  := aDepositLeg.
	withdrawlLeg := aWithdrawlLeg.
	
	depositLeg setCounterpart: withdrawlLeg.
	withdrawlLeg setCounterpart: depositLeg.
	
	transferAmount := anAmountOfPesos.! !


!Transfer methodsFor: 'transfer legs' stamp: 'fs 5/1/2024 17:00:19'!
depositLeg
	^depositLeg.! !

!Transfer methodsFor: 'transfer legs' stamp: 'fs 5/1/2024 17:00:16'!
withdrawlLeg
	^withdrawlLeg.! !


!Transfer methodsFor: 'amount' stamp: 'fs 5/1/2024 17:11:22'!
amountIs: anAmount
	^transferAmount = anAmount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'MB 5/4/2024 14:43:33'!
register: anAmountOfPesos from: transfererAccount to: transfereeAccount
	|depositLeg withdrawlLeg|
	
	(anAmountOfPesos = (0 * peso)) ifTrue: [ ^ self error: self invalidZeroAmount ].
	(anAmountOfPesos < (0 * peso)) ifTrue: [ ^ self error: self invalidNegativeAmount ].
	(transfererAccount == transfereeAccount) ifTrue: [^ self error: self cannotSelfTransfer].
	
	depositLeg := TransferDeposit register: anAmountOfPesos on: transfereeAccount.
	withdrawlLeg := TransferWithdrawl register: anAmountOfPesos on: transfererAccount.
	
	^ self new initializeWith: depositLeg and: withdrawlLeg forAnAmount: anAmountOfPesos.
	

	
	! !


!Transfer class methodsFor: 'error messages' stamp: 'fs 5/1/2024 17:24:46'!
cannotSelfTransfer
	^'Cannot self transfer'! !

!Transfer class methodsFor: 'error messages' stamp: 'fs 5/1/2024 17:16:42'!
invalidNegativeAmount
	^'Cannot transfer a negative amount'! !

!Transfer class methodsFor: 'error messages' stamp: 'MB 5/4/2024 14:42:39'!
invalidZeroAmount
	^ 'Cannot make a transfer with no amount of money'! !
