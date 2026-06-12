<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml" lang="hr">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Don Toliver — Diskografija</title>
  <meta name="description" content="Kompletan pregled Don Toliver studijskih albuma"/>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&amp;family=Inter:wght@300;400;500;600;700&amp;family=Grenze+Gotisch:wght@400;700&amp;family=Cormorant+Garamond:wght@400;600;700&amp;family=Dancing+Script:wght@400;700&amp;family=Metal+Mania&amp;family=Orbitron:wght@400;700&amp;display=swap" rel="stylesheet"/>
  <link href="disco.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<header id="site-header">
  <div class="header-inner">
    <span class="header-label">DISKOGRAFIJA</span>
    <h1 class="header-title">DON TOLIVER</h1>
    <a href="reviews.html" class="reviews-btn">Reviews</a>
  </div>
</header>

<main id="albums-container">
  <xsl:for-each select="Kolekcija/Album">
    <xsl:variable name="slug">
      <xsl:choose>
        <xsl:when test="Naziv = 'Heaven or Hell'">heaven</xsl:when>
        <xsl:when test="Naziv = 'Life of a DON'">life</xsl:when>
        <xsl:when test="Naziv = 'Love Sick'">love</xsl:when>
        <xsl:when test="Naziv = 'Hardstone Psycho'">hardstone</xsl:when>
        <xsl:when test="Naziv = 'OCTANE'">octane</xsl:when>
        <xsl:otherwise>default</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <section class="album-section" data-album="{$slug}">
      <div class="album-bg" style="background-image: url('{Omot}');"></div>
      <div class="album-overlay"></div>

      <div class="album-content">
        <div class="album-info-col">
          <span class="album-label">STUDIJSKI ALBUM</span>
          <span class="album-year"><xsl:value-of select="Godina"/></span>
          <h2 class="album-title"><xsl:value-of select="Naziv"/></h2>

          <div class="rating-stars" data-album="{Naziv}">
            <span class="star" data-value="1">&#9734;</span>
            <span class="star" data-value="2">&#9734;</span>
            <span class="star" data-value="3">&#9734;</span>
            <span class="star" data-value="4">&#9734;</span>
            <span class="star" data-value="5">&#9734;</span>
            <span class="rating-avg">(0.0)</span>
            <span class="rating-count">0 glasova</span>
          </div>

          <span class="album-artist"><xsl:value-of select="Izvođač"/></span>
          <div class="album-divider"></div>

          <div class="album-meta-items">
            <div class="meta-item">
              <span class="meta-label">Žanr:</span>
              <span class="meta-value"><xsl:value-of select="Zanr"/></span>
            </div>
            <div class="meta-item">
              <span class="meta-label">Izdavač:</span>
              <span class="meta-value"><xsl:value-of select="Izdavač"/></span>
            </div>
            <div class="meta-item">
              <span class="meta-label">Trajanje:</span>
              <span class="meta-value"><xsl:value-of select="Trajanje"/></span>
            </div>
             <div class="album-spotify">
              <a href="{SpotifyLink}" class="btn-spotify" target="_blank">▶ Listen on Spotify</a>
            </div>
          </div>
        </div>
        <div class="album-tracks">
          <div class="tracks-header">POPIS PJESAMA</div>
          <div class="tracks-grid">
            <xsl:for-each select="Pjesme/Pjesma">
              <div>
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="@hit = 'true'">track-item hit-track</xsl:when>
                    <xsl:otherwise>track-item</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <span class="track-number">
                  <xsl:choose>
                    <xsl:when test="@broj &lt; 10">0<xsl:value-of select="@broj"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@broj"/></xsl:otherwise>
                  </xsl:choose>
                </span>
                <span class="track-name">
                  <xsl:value-of select="."/>
                  <xsl:if test="@hit = 'true'"> &#9733;</xsl:if>
                </span>
                <span class="track-duration"><xsl:value-of select="@trajanje"/></span>
              </div>
            </xsl:for-each>
          </div>
        </div>
      </div>
    </section>
  </xsl:for-each>
</main>

<footer id="site-footer">
  <div class="footer-inner">
    <span class="footer-name">DON TOLIVER</span>
    <span class="footer-student">Kristijan Mavrović</span>
    <span class="footer-copy">JMBAG: 0246126887</span>
  </div>
</footer>

<script type="text/javascript">
<![CDATA[

// OCJENJIVANJE ZVJEZDICAMA

function getRatings() {
  var ratings = localStorage.getItem('albumRatings');
  if (ratings) return JSON.parse(ratings);
  return {
    "Heaven or Hell":   { sum: 0, count: 0, avg: 0 },
    "Life of a DON":    { sum: 0, count: 0, avg: 0 },
    "Love Sick":        { sum: 0, count: 0, avg: 0 },
    "Hardstone Psycho": { sum: 0, count: 0, avg: 0 },
    "OCTANE":           { sum: 0, count: 0, avg: 0 }
  };
}

function saveRatings(ratings) {
  localStorage.setItem('albumRatings', JSON.stringify(ratings));
}

function updateAllRatings() {
  var ratings = getRatings();
  var ratingDivs = document.querySelectorAll('.rating-stars');
  for (var i = 0; i < ratingDivs.length; i++) {
    var div = ratingDivs[i];
    var albumName = div.getAttribute('data-album');
    var albumRating = ratings[albumName];
    var avgSpan = div.querySelector('.rating-avg');
    var countSpan = div.querySelector('.rating-count');
    var stars = div.querySelectorAll('.star');
    if (albumRating && albumRating.count > 0) {
      var avg = albumRating.sum / albumRating.count;
      if (avgSpan) avgSpan.innerText = '(' + avg.toFixed(1) + ')';
      if (countSpan) countSpan.innerText = albumRating.count + ' glasova';
      var fullStars = Math.round(avg);
      for (var s = 0; s < stars.length; s++) {
        stars[s].innerText = s < fullStars ? '\u2605' : '\u2606';
      }
    } else {
      if (avgSpan) avgSpan.innerText = '(0.0)';
      if (countSpan) countSpan.innerText = '0 glasova';
      for (var s = 0; s < stars.length; s++) stars[s].innerText = '\u2606';
    }
  }
}

function rateAlbum(albumName, ratingValue) {
  var ratings = getRatings();
  if (ratings[albumName]) {
    ratings[albumName].sum += ratingValue;
    ratings[albumName].count++;
    ratings[albumName].avg = ratings[albumName].sum / ratings[albumName].count;
    saveRatings(ratings);
    updateAllRatings();
    updateRankingList();
  }
}

function attachStarEvents() {
  var allStars = document.querySelectorAll('.star');
  for (var i = 0; i < allStars.length; i++) {
    allStars[i].addEventListener('click', function() {
      var value = parseInt(this.getAttribute('data-value'));
      var albumName = this.parentElement.getAttribute('data-album');
      rateAlbum(albumName, value);
    });
    // Hover efekt
    allStars[i].addEventListener('mouseover', function() {
      var value = parseInt(this.getAttribute('data-value'));
      var siblings = this.parentElement.querySelectorAll('.star');
      for (var s = 0; s < siblings.length; s++) {
        siblings[s].innerText = s < value ? '\u2605' : '\u2606';
      }
    });
    allStars[i].addEventListener('mouseout', function() {
      updateAllRatings();
    });
  }
}


// RANG LISTA

function showRanking() {
  var ratings = getRatings();
  var rankingArray = [];
  for (var album in ratings) {
    rankingArray.push({ name: album, avg: ratings[album].avg, count: ratings[album].count });
  }
  rankingArray.sort(function(a, b) {
    return b.avg !== a.avg ? b.avg - a.avg : b.count - a.count;
  });

  var html = '<div class="ranking-overlay" id="rankingOverlay" onclick="closeRankingOutside(event)">';
  html += '<div class="ranking-content">';
  html += '<div class="ranking-header"><h2>&#127942; TOP LISTA ALBUMA</h2>';
  html += '<button class="ranking-close" onclick="closeRanking()">&#10006;</button></div>';
  html += '<div class="ranking-list">';

  for (var i = 0; i < rankingArray.length; i++) {
    var medal = i === 0 ? '&#129351;' : i === 1 ? '&#129352;' : i === 2 ? '&#129353;' : (i + 1) + '.';
    var fullStars = Math.round(rankingArray[i].avg);
    var starsDisplay = '';
    for (var s = 0; s < 5; s++) starsDisplay += s < fullStars ? '&#9733;' : '&#9734;';
    html += '<div class="ranking-item">';
    html += '<div class="ranking-position">' + medal + '</div>';
    html += '<div class="ranking-name">' + rankingArray[i].name + '</div>';
    html += '<div class="ranking-rating">' + starsDisplay + ' ' + rankingArray[i].avg.toFixed(1) + '</div>';
    html += '<div class="ranking-votes">(' + rankingArray[i].count + ' glasova)</div>';
    html += '</div>';
  }

  html += '</div>';
  html += '<div class="ranking-footer">Ocjene se spremaju lokalno u preglednik</div>';
  html += '</div></div>';
  document.body.insertAdjacentHTML('beforeend', html);
}

function closeRanking() {
  var overlay = document.getElementById('rankingOverlay');
  if (overlay) overlay.remove();
}

function closeRankingOutside(e) {
  if (e.target.id === 'rankingOverlay') closeRanking();
}

function updateRankingList() {
  var overlay = document.getElementById('rankingOverlay');
  if (!overlay) return;
  var ratings = getRatings();
  var rankingArray = [];
  for (var album in ratings) {
    rankingArray.push({ name: album, avg: ratings[album].avg, count: ratings[album].count });
  }
  rankingArray.sort(function(a, b) {
    return b.avg !== a.avg ? b.avg - a.avg : b.count - a.count;
  });
  var listDiv = overlay.querySelector('.ranking-list');
  if (!listDiv) return;
  var html = '';
  for (var i = 0; i < rankingArray.length; i++) {
    var medal = i === 0 ? '&#129351;' : i === 1 ? '&#129352;' : i === 2 ? '&#129353;' : (i + 1) + '.';
    var fullStars = Math.round(rankingArray[i].avg);
    var starsDisplay = '';
    for (var s = 0; s < 5; s++) starsDisplay += s < fullStars ? '&#9733;' : '&#9734;';
    html += '<div class="ranking-item">';
    html += '<div class="ranking-position">' + medal + '</div>';
    html += '<div class="ranking-name">' + rankingArray[i].name + '</div>';
    html += '<div class="ranking-rating">' + starsDisplay + ' ' + rankingArray[i].avg.toFixed(1) + '</div>';
    html += '<div class="ranking-votes">(' + rankingArray[i].count + ' glasova)</div>';
    html += '</div>';
  }
  listDiv.innerHTML = html;
}


// UPDATE

updateAllRatings();
attachStarEvents();
]]>
</script>

</body>
</html>

</xsl:template>
</xsl:stylesheet>
