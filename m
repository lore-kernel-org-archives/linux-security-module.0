Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917D1C4A24
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766885364; cv=none; b=mDQ8DbDs/QfFToQWuUJ93jC0PDyvzCh5iPIXnCMSbi56/zDbK5wOog6scYZQ3oiNSkOfwIDA0MD3ZVemg+zjqjn9Ht0hLiy3CktLrpg8k1PoRj82M1NVDOQCeg6ZP7nKDFQe+/wLcp8sPbKWS52Qdd/6CMSG4PmdQxbJsaIb7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766885364; c=relaxed/simple;
	bh=mfTVxmiGwwzt3oWYkSACng2R+d6n+qxrP2A9BY/O7N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMarcQ1KPzvDacs5FVXspRWXzvcoqGoGcgf1aeLUG3s68IjVeum9u4DiYjwNYA3KItutZN4H/GbooiLYwKhTPV3eJWRcJKgUTefbCOpdL9ZWqs5Jg1+ONkYg+yJAX3329hUSC9Yc41PF1erxC8TqJSDRUi6JC/6amDx40yg66zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=JrIMGDbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iY72vJHu; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="JrIMGDbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iY72vJHu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F3B6140009A;
	Sat, 27 Dec 2025 20:29:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 27 Dec 2025 20:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766885361; x=
	1766971761; bh=Use78IikGJzN8WjGNRDI7flPNtG2z68F/1UOley/NHw=; b=J
	rIMGDbdYzpG45iGW5ux5TyXmqCPKnu5GBhEQmy0U182gaaNLaP3i+lZaVZxUPHU+
	ljpZS7elRa9C7fxyBMylbfWqqICZ5eU4iIrfZKnswmiYmGB5Z8DJfWJVmRtTcume
	pzAEdjX0Ibuv9WelM4XeJvT9tVsR0b5+dMpmtFXkfc6ZLj6A46TNg2l6BGgA2EQZ
	WaOgo8HrOeTuhyzrHExv1HsvsTfZimvod348gzCOEN7u3woI9UoizWY15uf1hFEA
	IJfbCg8GYQde2CN3ojQOWf/sdluVwudWyNT3W5UTuz8VRihbV99LCNmhdG4lb65t
	wBB4BTRAqO8fpVnIsNoTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766885361; x=1766971761; bh=U
	se78IikGJzN8WjGNRDI7flPNtG2z68F/1UOley/NHw=; b=iY72vJHuRNRXp7qyO
	lQbU6lqS69vd2zioAGxzICTZGgUv3XkeVMU6QrsIeRUY4hlmQyKW8Uo2dtHdl8KZ
	bRQ62hoCOEo2ar3ix4WGWdkvyvWJUKZnBCYtmBhfU6rvI710LD/VniTdDb6ir84j
	ySOdty3hch9DMDTvgbvuuetNEsuRlMkU2UE64JvlgOkVeSBew/+Twy9uy2kBcIsF
	BmrAy3P5NuHfix+T6/gRgfjc2du6kjzJ31z6WgqBMS7Qk3Abbnk9PU1kv7mxHJdS
	6BFHxNNubcElGt2wrN1+IsUcBxem1Hp/Q0F9LO77jJa3XyMU2576pZ4JVDSb1MgJ
	z4Iyg==
X-ME-Sender: <xms:8YdQaea8cQvnyTT-Nep0aBV1spvVLI3FXaNCRhds6Yvq57Ze-UmaTg>
    <xme:8YdQaYT4WMJTBsqAOB0PXigXp-tk_ElJHjKvge4zG_xbXC9hCEemTISbZLbzpi776
    Jow9pCigdtusk7-RIkO5-iVOHc-SwtiNr_uk8z7untw0C4aAfxEtRM>
X-ME-Received: <xmr:8YdQaRT76uNHSFTuXiX8Zq-NjHxvx4TyvboUqZzS_XhgxPTkVgy80f2Ectqt0r2XYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepledvgf
    eivdehveejudeiveehteeghffhkeejteekteegleefhfeihfeigefftdffnecuffhomhgr
    ihhnpegsvghtthgvrhdrshgvtghurhhithihnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkoh
    gurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepghhn
    ohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrih
    hthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhgr
    hhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8YdQacQJsnyko_xvydjul2J0QzvT2m_jJoXcb6FbikpkEaZs-sAvrw>
    <xmx:8YdQaW79WToVbiVjRwbBOJkN7HlV5I1wzhZJur50S-dMZR2ubMfrXw>
    <xmx:8YdQaY0VZrvbzzk5nk4mEwFUvkQ4JPDYal97zBsK8Q3hSArpKaaqhA>
    <xmx:8YdQaRAjCfz95qQXxxYC4x25xqQKS1Pf74f5oUpxtFCDqnoY5vU4CA>
    <xmx:8YdQaXvHqO2rOeCcxmI7Y0qywdzrNF3a0m7-gzj0LI4_HDSNB8dfanth>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:29:20 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [RFC PATCH 5/5] landlock: Improve the comment for domain_is_scoped
Date: Sun, 28 Dec 2025 01:27:35 +0000
Message-ID: <06393bc18aee5bc278df5ef31c64a05b742ebc10.1766885035.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766885035.git.m@maowtm.org>
References: <cover.1766885035.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently it is not obvious what "scoped" mean, and the fact that the
function returns true when access should be denied is slightly surprising
and in need of documentation.

Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Open to discussion on whether this actually explains it better.

 security/landlock/task.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index bf4ed15a7f01..6dfcc1860d6e 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -166,15 +166,16 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 }
 
 /**
- * domain_is_scoped - Checks if the client domain is scoped in the same
- *		      domain as the server.
+ * domain_is_scoped - Check if an interaction from a client/sender to a
+ *    server/receiver should be restricted based on scope controls.
  *
  * @client: IPC sender domain.
  * @server: IPC receiver domain.
  * @scope: The scope restriction criteria.
  *
- * Returns: True if the @client domain is scoped to access the @server,
- * unless the @server is also scoped in the same domain as @client.
+ * Returns: True if the @server is in a different domain from @client, and
+ *    the @client domain is scoped to access the @server (i.e. access
+ *    should be denied).
  */
 static bool domain_is_scoped(const struct landlock_ruleset *const client,
 			     const struct landlock_ruleset *const server,
-- 
2.52.0
