--공지 페이지용 SQL
CREATE TABLE tbl_noti_board(--공지 게시판용 테이블
	bno			NUMBER(10, 0),		
	title			NVARCHAR2(50)	NOT NULL,
	content			NVARCHAR2(2000) NOT NULL,
	writer			NVARCHAR2(50)	NOT	NULL,
	regdate			DATE	DEFAULT sysdate,--등록날짜
	updatedate		DATE	DEFAULT	sysdate	--업데이트 날짜
);
create sequence seq_noti_board;
alter table tbl_noti_board add constraint noti_pk primary key (bno); 
-- bno번호 중복 안되도록 pk부여

CREATE TABLE tbl_noti_reply(--공지 댓글처리용 테이블, bno라는 칼럼을 이용해서 해당 댓글이 어떤 공지의 댓글인지 명시 
	rno number(10, 0),
	bno number(10, 0) not null,
	reply nvarchar2(1000) not null,
	replyer nvarchar2(50) not null,
	replyDate date default sysdate,
	updateDate date default sysdate
);
create sequence seq_noti_reply;
alter table tbl_noti_reply add constraint pk_reply primary key(rno);
-- rno번호 중복 안되도록 pk부여

alter table tbl_noti_reply and constraint fk_reply_board foreign key(bno) 
references tbl_noti_board(bno);
-- 외래키(FK) 설정하여 tbl_noti_board 테이블을 참조하도록 설정





        
        
        
