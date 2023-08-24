<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/top.jsp"/>
<!-- Your own style tag or CSS file -->
<link rel="stylesheet" href="${path}/resources/css/store/storePurchase.css">
<!------------------------------------>
<title>롤코지지</title>
</head>
<body oncontextmenu="return false">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="navBgColor" value="nav-black"/>
</jsp:include>
    <section>
    	<div class="clickinfo">
    		<div>
    			<p>좌클릭 : 회전</p>
    		</div>
    		<div>
    			<p>우클릭 : 이동</p>
    		</div>
    		<div>
    			<p>휠 : 확대,축소</p>
    		</div>
    		<div>
    			<p>위치 초기화 후 휠 확대 또는 축소</p>
    		</div>
    	</div> 
	    <div id="container"></div>
		<div id="menu">
			<button id="helix">둥글게보기</button>
			<button id="table">일자로 보기</button>
			<button id="reset">위치 초기화</button>
			<button id="store">상점으로</button>
		</div>
    </section>
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<script src="${path}/resources/js/script_common.js"></script>
<!-- Your own script tag or JavaScript file -->
<script async src="https://unpkg.com/es-module-shims@1.6.3/dist/es-module-shims.js"></script>

<script type="importmap">
	{
		"imports": {
			"three": "https://unpkg.com/three@0.155.0/build/three.module.js",
			
			"three/addons/": "${path}/resources/js/3d/"
		}
	}
</script>

<script type="module">
			
			import * as THREE from 'three';
			import TWEEN from 'three/addons/tween.module.js';
			import { TrackballControls } from 'three/addons/TrackballControls.js';
			import { CSS3DRenderer, CSS3DObject } from 'three/addons/CSS3DRenderer.js';


			const table = [
			<c:if test="${not empty cardPack}">
							<c:forEach var="c" items="${cardPack }">
								<c:set var="cardName1" value="${c.card.cardName }" />
								<c:set var="cardName2" value="${fn:toLowerCase(cardName1)}" />
				<c:set var="i" value="${i+1}"/>
					'${c.card.cardClass.cardClassName }','${c.card.cardName }','${c.card.cardSeason }','${c.card.teamName}','${cardName2 }','${c.card.teamName }',${i}, 1,
				
				</c:forEach>
							</c:if>
			<c:if test="${not empty emopack}">
				<c:forEach var="p" items="${emopack }">
				<c:set var="i" value="${i+1}"/>
					'${p.emoNo.emoName}',${i}, 1,
				</c:forEach>
			</c:if>
			];

			let camera, scene, renderer;
			let controls;

			const objects = [];
			const targets = { table: [], helix: []};

			init();
			animate();

			function init() {

				camera = new THREE.PerspectiveCamera( 4000, window.innerWidth / window.innerHeight, 1, 10000 );
				camera.position.z = 1300;

				scene = new THREE.Scene();

				// table
				<c:if test="${not empty cardPack}">
				for ( let i = 0; i < table.length; i += 8 ) {

					const element = document.createElement( 'div' );
					element.className = 'element';


					let html ='';
		        	    	  
		        	        html += '<div class="card_img">';
		        	        html += '<div class="card_content_div">';
		        	        html += '<div class="card_content">';
		        	        html += '<div class="back">';
		        	        html += '<div class="back-content">';
		        	        html += '<div class="card_info_div">';
		        	        html += '<strong>';
		        	        html += '<img src="${path }/resources/images/card/' + table[ i ] +'.png" alt="" width="250px" height="350px" class="player_img">';
		        	        html += '</strong>';
		        	        html += '<div class="card_player_info">';
		        	        html += '<p class="title  player_name">'+table[ i+1 ]+'<p>';
		        	        html += '<p class="content player_season">'+table[ i+2 ]+'</p>';
		        	        html += '<img src="${path }/resources/images/player/'+table[ i+3 ]+'_roster_'+table[ i+4 ]+'1.png" alt="" class="player" width="170px" height="250px">';
		        	        html += '<img src="${path }/resources/images/logo/'+table[ i+5 ]+'_logo_small.png" alt="" class="player_team_logo">';
		        	        html += '</div></div></div></div></div></div></div>'
		        	        html += '</div></div></div></div></div></div></div>';




					element.innerHTML=html;

					

					const objectCSS = new CSS3DObject( element );
					objectCSS.position.x = Math.random() * 4000 - 2000;
					objectCSS.position.y = Math.random() * 4000 - 2000;
					objectCSS.position.z = Math.random() * 4000 - 2000;
					scene.add( objectCSS );

					objects.push( objectCSS );


					const object = new THREE.Object3D();
					object.position.x = ( table[ i + 6 ] * 300 ) - 890;
					object.position.y = - ( table[ i + 7 ] * 180 ) + 190;

					targets.table.push( object );
				}
				</c:if>
				<c:if test="${not empty emopack}">
				for ( let i = 0; i < table.length; i += 3 ) {

					const element = document.createElement( 'div' );
					element.className = 'element';


					const img = document.createElement( 'img' );
					img.setAttribute("src", "${path}/resources/images/emoticon/"+table[ i ]+".png");
					img.setAttribute("width", "200");
					img.setAttribute("height", "318");
					element.appendChild( img );


					const objectCSS = new CSS3DObject( element );
					objectCSS.position.x = Math.random() * 4000 - 2000;
					objectCSS.position.y = Math.random() * 4000 - 2000;
					objectCSS.position.z = Math.random() * 4000 - 2000;
					scene.add( objectCSS );

					objects.push( objectCSS );


					const object = new THREE.Object3D();
					object.position.x = ( table[ i + 1 ] * 300 ) - 890;
					object.position.y = - ( table[ i + 2 ] * 180 ) + 190;

					targets.table.push( object );
				}
				</c:if>

				const vector = new THREE.Vector3();


				for ( let i = 0, l = objects.length; i < l; i ++ ) {

					const theta = i * 1.3 + Math.PI;
					const y = - ( i * 8 ) + 50;

					const object = new THREE.Object3D();

					object.position.setFromCylindricalCoords( 400, theta, y );

					vector.x = object.position.x * 2;
					vector.y = object.position.y * 1.5;
					vector.z = object.position.z * 2;
					

					object.lookAt( vector );

					targets.helix.push( object );

				}


				

				renderer = new CSS3DRenderer();
				renderer.setSize( window.innerWidth, window.innerHeight );
				document.getElementById( 'container' ).appendChild( renderer.domElement );

				//

				controls = new TrackballControls( camera, renderer.domElement );
				controls.minDistance = 300;
				controls.maxDistance = 10000;
				controls.rotateSpeed = 5;
				controls.addEventListener( 'change', render );

				

				const buttonTable = document.getElementById( 'table' );
				buttonTable.addEventListener( 'click', function () {

					transform( targets.table, 1500 );

				} );

				const buttonHelix = document.getElementById( 'helix' );
				buttonHelix.addEventListener( 'click', function () {
					transform( targets.helix, 1500 );

				} );


				transform( targets.helix, 1500 );

				//

				window.addEventListener( 'resize', onWindowResize );

				const buttonreset = document.getElementById( 'reset' );
				buttonreset.addEventListener( 'click', function () {
					camera = new THREE.PerspectiveCamera( 40, window.innerWidth / window.innerHeight, 1, 10000 );
					camera.position.z = 1300;
					controls = new TrackballControls( camera, renderer.domElement );
					controls.minDistance = 300;
					controls.maxDistance = 10000;
					controls.rotateSpeed = 5;
					controls.addEventListener( 'change', render );

				} );
				const buttonStore = document.getElementById( 'store' );
				buttonStore.addEventListener( 'click', function () {
					location.replace('${path}/store/main');

				} );

			}

			function transform( targets, duration ) {

				TWEEN.removeAll();

				for ( let i = 0; i < objects.length; i ++ ) {

					const object = objects[ i ];
					const target = targets[ i ];

					new TWEEN.Tween( object.position )
						.to( { x: target.position.x, y: target.position.y, z: target.position.z }, Math.random() * duration + duration )
						.easing( TWEEN.Easing.Exponential.InOut )
						.start();

					new TWEEN.Tween( object.rotation )
						.to( { x: target.rotation.x, y: target.rotation.y, z: target.rotation.z }, Math.random() * duration + duration )
						.easing( TWEEN.Easing.Exponential.InOut )
						.start();

				}

				new TWEEN.Tween( this )
					.to( {}, duration * 2 )
					.onUpdate( render )
					.start();

			}

			function onWindowResize() {

				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();

				renderer.setSize( window.innerWidth, window.innerHeight );

				render();

			}

			function animate() {

				requestAnimationFrame( animate );

				TWEEN.update();

				controls.update();

			}

			function render() {

				renderer.render( scene, camera );

			}

			

</script>

<script>
window.onload = function onloadEvent() {
	let cards = document.querySelectorAll(".player_img");
	let backs = document.querySelectorAll(".back");

	for (let i = 0; i < cards.length; i++) {
		if (cards[i].getAttribute("src").includes("COMMON")) {
			backs[i].classList.add("common");
		} else if (cards[i].getAttribute("src").includes("NORMAL")) {
			backs[i].classList.add("normal");
		} else if (cards[i].getAttribute("src").includes("UNIQUE")) {
			backs[i].classList.add("unique");
		}
	}
}
function noRefresh()
{
    /* CTRL + N키 막음. */
    if ((event.keyCode == 78) && (event.ctrlKey == true))
    {
        event.keyCode = 0;
        return false;
    }
    if ((event.keyCode == 82) && (event.ctrlKey == true))
    {
        event.keyCode = 0;
        return false;
    }
    /* F5 번키 막음. */
    if(event.keyCode == 116)
    {
        event.keyCode = 0;
        return false;
    }
}

document.onkeydown = noRefresh ;
</script>
<!-------------------------------------------->
</body>
</html>
