#include <QString>
#include <QtTest>

class recipeManagerTest : public QObject
{
    Q_OBJECT
    
public:
    recipeManagerTest();
    
private Q_SLOTS:
    void testCase1();
};

recipeManagerTest::recipeManagerTest()
{
}

void recipeManagerTest::testCase1()
{
    QVERIFY2(true, "Failure");
}

QTEST_APPLESS_MAIN(recipeManagerTest)

#include "tst_recipemanagertest.moc"
