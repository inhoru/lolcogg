<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="team" value="${requestScope.team}"/>
<c:set var="matches" value="${requestScope.matches}"/>
<jsp:include page="/WEB-INF/views/common/top.jsp"/>
<link rel="stylesheet" href="${path}/resources/css/teamdata/style_team.css">
<title>팀 - <c:out value="${team.TEAM_ABBR}"/></title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="navBgColor" value="nav-black"/>
</jsp:include>
    <section>
        <div class="center-1280 background-img mainpage mainHeight">
            <div class="width-1280 page-margin">
                <div>
                    <p class="subTitle fs-20">TEAM DATA</p>
                    <p class="mainTitle fs-35 mainTitleMargin">팀 데이터</p>
                </div>
                <div class="team-title">
                    <div class="team-title_upper">
                        <h2 class="title">${team.TEAM_ABBR}</h2>
                        <div>
                            <img src="">
                        </div>
                    </div>
                    <div class="team-title_lower">
                        <p class="title">${team.TEAM_NAME}</p>
                    </div>
                </div>

                <div class="team-stats">
                    <div class="team-stats-element">
                        <p>순위</p>
                        <h3>${team.TEAM_RANK}</h3>
                    </div>
                    <div class="flex-grow"></div>
                    <div class="team-stats-element">
                        <p>경기 횟수</p>
                        <h3>${team.NUM_OF_MATCH_WINS + team.NUM_OF_MATCH_DEFEATS}</h3>
                    </div>
                    <div class="team-stats-element">
                        <p>승리</p>
                        <h3>${team.NUM_OF_MATCH_WINS}</h3>
                    </div>
                    <div class="team-stats-element">
                        <p>패배</p>
                        <h3>${team.NUM_OF_MATCH_DEFEATS}</h3>
                    </div>
                    <div class="team-stats-element">
                        <p>득실차</p>
                        <div class="stats-element_sb">
                            <h3>${team.NUM_OF_GAME_WINS - team.NUM_OF_GAME_DEFEATS}</h3>
                            <span class="fw-bold" style="color: #5F5F5F;">(${team.NUM_OF_GAME_WINS}W / ${team.NUM_OF_GAME_DEFEATS}L)</span>
                        </div>
                    </div>
                </div>
                <div class="team-stats-date">
                    <p class="fw-bold" style="color: #5F5F5F;">*<fmt:formatDate value="${team.UPDATE_DATE}" type="date" dateStyle="long"/> 기준</p>
                </div>

                <div class="team-players">
                    <div class="bar-layout">
                        <hr class="flex-grow">
                        <p class="fw-bold">선수</p>
                        <hr class="flex-grow">
                    </div>
                    <div class="team-players-info">
                        <div class="players-name">
                            <div>
                                <p>TOP</p>
                                <div class="top name-list"></div>
                            </div>
                        </div>
                        <div class="player-symbol">
                            <img src="${path}/resources/images/position/circle_top.svg">
                        </div>
                    </div>
                    <div class="team-players-info">
                        <div class="players-name">
                            <div>
                                <p>JUNGLE</p>
                                <div class="jungle name-list"></div>
                            </div>
                        </div>
                        <div class="player-symbol">
                            <img src="${path}/resources/images/position/circle_jungle.svg">
                        </div>
                    </div>
                    <div class="team-players-info">
                        <div class="players-name">
                            <div>
                                <p>MID</p>
                                <div class="mid name-list"></div>
                            </div>
                        </div>
                        <div class="player-symbol">
                            <img src="${path}/resources/images/position/circle_mid.svg">
                        </div>
                    </div>
                    <div class="team-players-info">
                        <div class="players-name">
                            <div>
                                <p>BOT</p>
                                <div class="bot name-list"></div>
                            </div>
                        </div>
                        <div class="player-symbol">
                            <img src="${path}/resources/images/position/circle_bot.svg">
                        </div>
                    </div>
                    <div class="team-players-info">
                        <div class="players-name">
                            <div>
                                <p>SUPPORT</p>
                                <div class="support name-list"></div>
                            </div>
                        </div>
                        <div class="player-symbol">
                            <img src="${path}/resources/images/position/circle_support.svg">
                        </div>
                    </div>
                    <div class="team-players-card">
                        <div class="card-inner">
                            <div class="card-back">
                                <div>
                                    <img src="">
                                </div>
                            </div>
                            <div class="card-front">
                                <h3></h3>
                                <div>
                                    <img src="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="team-match_scheduled">
                    <div class="bar-layout">
                        <hr class="flex-grow">
                        <p class="fw-bold">예정 경기</p>
                        <hr class="flex-grow">
                    </div>
                    <table class="match-table">
                        <tbody>
                        	<c:choose>
                        		<c:when test="${matchSchedule ne null and not empty matchSchedule}">
                        			<c:forEach var="match" items="${matchSchedule}" varStatus="status">
	                        			<c:if test="${status.index < 5}">
	                        				<tr>
	                                        	<td class="match_date"><h3><fmt:formatDate value="${match.MS_DATE}" type="both" pattern="MM.dd (E) HH:mm"/></h3></td>
	                                        	<td class="home">
	                                        		<h3 class="fw-bolder team_versus"><c:out value="${match.MS_HOME}"/></h3>
	                                        	</td>
	                                        	<td>
	                                        		<div>
	                                        			<img src="${path}/resources/images/logo/${match.MS_HOME}_small.png">
	                                        		</div>
	                                        	</td>
	                                        	<td><h3 class="title">VS</h3></td>
	                                        	<td class="away">
	                                        		<h3 class="fw-bolder team_versus"><c:out value="${match.MS_AWAY}"/></h3>
	                                        	</td>
	                                        	<td>
	                                        		<div>
	                                        			<img src="${path}/resources/images/logo/${match.MS_AWAY}_small.png">
	                                        		</div>
	                                        	</td>
	                                        	<td>
	                                        		<div class="match-table_option">
	                                        			<input type="button" class="match-btn compare-btn" value="전력 비교"/>
	                                        		</div>
	                                        	</td>
	                        				</tr>
	                        			</c:if>
	                        		</c:forEach>
                        		</c:when>
	                            <c:otherwise>
	                                <tr>
	                                    <td colspan="7"><h3>예정된 경기가 없습니다.</h3></td>
	                                </tr>
	                            </c:otherwise>
                        	</c:choose>
                        </tbody>
                    </table>
                </div>

                <div class="team-match_history">
                    <div class="bar-layout">
                        <hr class="flex-grow">
                        <p class="fw-bold">종료 경기</p>
                        <hr class="flex-grow">
                    </div>
                    <table class="match-table">
                    	<tbody>
                        	<c:if test="${matchHistory ne null}">
                        		<c:forEach var="match" items="${matchHistory}" varStatus="status">
                        			<c:if test="${status.index < 5}">
                        				<tr>
                                        	<td class="match_date"><h3><fmt:formatDate value="${match.MS_DATE}" type="both" pattern="MM.dd (E) HH:mm"/></h3></td>
                                        	<td class="home">
                                        		<h3 class="fw-bolder team_versus"><c:out value="${match.MS_HOME}"/></h3>
                                        	</td>
                                        	<td>
                                        		<div>
                                        			<img src="${path}/resources/images/logo/${match.MS_HOME}_small.png">
                                        		</div>
                                        	</td>
                                        	<td><h3 class="title"><c:out value="${match.MS_HOME_SCORE} : ${match.MS_AWAY_SCORE}"/></h3></td>
                                        	<td class="away">
                                        		<h3 class="fw-bolder team_versus"><c:out value="${match.MS_AWAY}"/></h3>
                                        	</td>
                                        	<td>
                                        		<div>
                                        			<img src="${path}/resources/images/logo/${match.MS_AWAY}_small.png">
                                        		</div>
                                        	</td>
                                        	<td>
                                        		<div class="match-table_option">
                                        			<input type="button" class="match-btn detail-btn" value="상세 보기"/>
                                        		</div>
                                        	</td>
                        				</tr>
                        			</c:if>
                        		</c:forEach>
                        	</c:if>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<script src="${path}/resources/js/script_common.js"></script>
<script>
    $.get("${path}/resources/images/team_img.json")
        .then(data => {
            data.forEach((team, index) => {
                if (team.teamAbbr === "${team.TEAM_ABBR}") {
                    $(".team-title_upper img").attr("src", "${path}/resources/images/logo/" + team.logo.big);

                    $(".team-title_lower").css("backgroundColor", team.color);

                    $(".card-back img").attr("src", "${path}/resources/images/logo/" + team.logo.white);

                    team.players.top.forEach((topPlayer, index) => {
                        index == 0 ? $(".top").append($("<input type='button'>").val(topPlayer.name.toUpperCase())) : $(".top").append($("<span>").text("|")).append($("<input type='button'>").val(topPlayer.name.toUpperCase()));
                    });

                    team.players.jungle.forEach((junglePlayer, index) => {
                        index == 0 ? $(".jungle").append($("<input type='button'>").val(junglePlayer.name.toUpperCase())) : $(".jungle").append($("<span>").text("|")).append($("<input type='button'>").val(junglePlayer.name.toUpperCase()));
                    });

                    team.players.mid.forEach((midPlayer, index) => {
                        index == 0 ? $(".mid").append($("<input type='button'>").val(midPlayer.name.toUpperCase())) : $(".mid").append($("<span>").text("|")).append($("<input type='button'>").val(midPlayer.name.toUpperCase()));
                    });

                    team.players.bot.forEach((botPlayer, index) => {
                        index == 0 ? $(".bot").append($("<input type='button'>").val(botPlayer.name.toUpperCase())) : $(".bot").append($("<span>").text("|")).append($("<input type='button'>").val(botPlayer.name.toUpperCase()));
                    });

                    team.players.support.forEach((supportPlayer, index) => {
                        index == 0 ? $(".support").append($("<input type='button'>").val(supportPlayer.name.toUpperCase())) : $(".support").append($("<span>").text("|")).append($("<input type='button'>").val(supportPlayer.name.toUpperCase()));
                    });

                    $(document).on("mouseover", ".name-list", event => {
                        if ($(event.target).prop("tagName") === "INPUT") {
                            const playerName = $(event.target).val();
                            const position = $(event.target).parent().siblings("p").text().toLowerCase();
            
                            $(".card-front h3").text(playerName);
            
                            team.players[position].forEach((player, index) => {
                                if (player.name === playerName.toLowerCase()) {
                                    $(".card-front img").attr("src", "${path}/resources/images/player/" + player.image[0]);
                                }
                            });
            
                            $(".card-inner").css("transform", "rotateY(180deg)");
                        }
                    });

                    $(document).on("mouseout", ".name-list", event => {
                        $(".card-inner").css("transform", "rotateY(0deg)");
                    });
                }
            });
        });

        $(document).on("click", ".name-list input[type=button]", event => {
            location.assign("${path}/teamdata/player?nickname=" + $(event.target).val());
        });

        $(document).on("click", ".detail-btn", event => {
            const matchDate = "23-" + $(event.target).parent().parent().siblings(".match_date").find("h3").text().split(" ")[0].replace(".", "-");
            const home = $(event.target).parent().parent().siblings(".home").find("h3").text();
            const away = $(event.target).parent().parent().siblings(".away").find("h3").text();

            location.assign("${path}/teamdata/matchResult?matchDate=" + matchDate + "&home=" + home + "&away=" + away);
        });

        $(document).on("click", ".compare-btn", event => {
            const home = $(event.target).parent().parent().siblings(".home").find("h3").text();
            const away = $(event.target).parent().parent().siblings(".away").find("h3").text();

            location.assign("${path}/teamdata/comparison?teamLeft=" + home + "&teamRight=" + away);
        });

        $(document).on("mouseenter", ".name-list input[type='button']", event => {
            $(event.target).addClass("neon");
        });

        $(document).on("mouseleave", ".name-list input[type='button']", event => {
            $(event.target).removeClass("neon");
        });
</script>
</body>
</html>
