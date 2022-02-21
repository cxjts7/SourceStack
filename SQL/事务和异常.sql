--用户发布一篇悬赏币若干的求助（TProblem），他（TReigister）的
--帮帮币（BMoney）也会相应减少，但他的帮帮币总额不能少于0分：
--请综合使用TRY...CATCH和事务完成上述需求。

create table TProblem(
    Id int,
    Problem int
);

create table TReigister(
    Id int,
    BMoney int CONSTRAINT CK_TReigister_BMoney CHECK(BMoney>0)
);



BEGIN TRANSACTION
BEGIN TRY
    UPDATE TProblem SET Problem = Problem + 1 WHERE Id = 1
    UPDATE TReigister SET BMoney = BMoney - 10 WHERE Id = 1
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@TRANCOUNT>0
        ROLLBACK;
    THROW;
END CATCH

select * from TProblem;
select * from TReigister;