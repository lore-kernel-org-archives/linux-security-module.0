Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91327AC45
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160397; cv=none; b=iP8+WYU+Tl7c35LWMPVjcboGjE5XCCD3QY0mFgBoFcERJENSNDW6leZgjIjj2WRTif+fRqk0E/rBSUqNEKvVx6i3UfS4fTmwSrLhw6ZQ5/dj/cIzfHxxDlVrk6Gjwgbj87zkzGyqLY5kRIuK8HfvvsquVM2r/BLTEJGXnkoezfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160397; c=relaxed/simple;
	bh=UG+p8ucDSms9RIpNHryjWM/R7MdjI07ubZx1leS9gTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQcxfQaXJO1+v+NRWZBx80kJiNqProK0wO/NyAcUwUgMXxsDKSo6yQh0POEasKGg81ewMF+/iEBnbyM3Y1NjVRwIW/OToQTBRDUCVeEp/IXzxXM00aqSbeoQ4EIiwWkcIvg0l+HS9KTKhH3KDdDnEfqOWKZ5sBfbwfAh9nUDDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=daBljE9I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKd90ab7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="daBljE9I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKd90ab7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24ECF14000C9;
	Tue,  3 Feb 2026 18:13:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 18:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770160395; x=
	1770246795; bh=ZqQJQnAJd+PF8S1jvhPB6VOPmrx5r+uOrxA/vvV9/m0=; b=d
	aBljE9IwX9ShbDtkVz6xDlVD7ReoTPZdOcYliJLD6YXHLRpoxag2Jr3LxMnYlQRV
	y7zo/kV6VuUqlrGLC1/2hrN0J5HCJdej5cT4nCjQdjy2pd3ai/n7/AkMCFmPKbQt
	VzD38T+aUe1VAXbqvpudUMJCEAU4uHUAlLHSDmkXjdYoR1CVk5mtpiB79xAZpBCB
	5yMrlrxBhshBqOOHWJkaedH4jZD2g4OplrSmTtMI378X2nx1PEcX6ZwTPHsTYHxJ
	4BzagcD9VXITipmY5liGH2QCufYik4HnP11ATIx9YOQMY5GN+gb/sWwxdcRorqf8
	bJiPRacoKfKNGy/95M+3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770160395; x=1770246795; bh=Z
	qQJQnAJd+PF8S1jvhPB6VOPmrx5r+uOrxA/vvV9/m0=; b=fKd90ab7Ht4pyEcHb
	2eWj7RSXImc96Plup6KCggqQRiNOmvzXUTW02E/vHECrFpRUqML5CfuN0tQRxQqF
	hiWmS5hemHhK6e+7kNgvqJPamXMY6Vlkqo8GNC/s+ONjTDuuN1TywW+yAUaWQPqn
	/VNTR6Yzt8w01yLvyGRiMY71ZKrwU/jQVWYsEawGnR+SIcMj9+u5W0aDe16Wd/KW
	mM4tTYWKNuPK0bK+0atyMN7bDlKREJRgzBftCbo5xS7i3V2T7WvA4lpfpCJl5Yzj
	qQjc1nZYu+4joHBq2bh0u+axkTAlO9TBx86IlyFkCm1h8q6lWpNlil7LQ7SmElGN
	TZ5xQ==
X-ME-Sender: <xms:C4GCaXYuwhDbLzu1erSBti9li94EOxsaIAF4ObOk-R72ookyFEsRag>
    <xme:C4GCaY-s5_MR4ikvD5SzTLhjml3fE3V0QQA4vsmWa3Bn4VKx5uVXLnMzmd94IHVIr
    RejBfdgf7bE_S-Mdr95mYcOPh-XQiiA22hqs0LtiZk8DdnipXnfhQzC>
X-ME-Received: <xmr:C4GCadnHnpuMPmdwEcDNCkhLEVQ9aLW9ycwCB6-TuJ6XWycCeP0YAZ93SXBFwMtxZwDIDlaEdPwJq0r1tZ0VUIGSG-_A97S3oqUgf8F9yB0uZ7Y-DMe6joY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uggvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhi
    hsshgrrdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehuth
    hilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    shgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C4GCadzCwGHkfEoKaT0_GqDFMfthFR0sik9URuviVOZwxhwttBUOVg>
    <xmx:C4GCaX7PdLoVSI5yfCfbTiaRAzPfuGffxK_r1zwKyqUaqdUXXHyZMQ>
    <xmx:C4GCadVC8fOLiL6aDtyqd-XbQAAQ3khNKqxyF79VQoFZ_V1WilRKvQ>
    <xmx:C4GCafLOJ7ttGFKTwm9MGosOjVKj6XdRI4hv4W3unoJznZgvxs1bxw>
    <xmx:C4GCabVmg_W6tYHc40Esmfp0PwoKPuCTqyIQrE5GgmsRLgLWQAMUCznr>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:13:13 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 3/6] samples/landlock: Support LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Date: Tue,  3 Feb 2026 23:12:30 +0000
Message-ID: <8a93c69db32889fb156a5293307a02aabc0c9617.1770160146.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770160146.git.m@maowtm.org>
References: <cover.1770160146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for this new scope bit to the sandboxer via LL_SCOPED=u

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v3:
- Add message

 samples/landlock/sandboxer.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..2de14e1c787d 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -234,14 +234,16 @@ static bool check_ruleset_scope(const char *const env_var,
 	bool error = false;
 	bool abstract_scoping = false;
 	bool signal_scoping = false;
+	bool named_scoping = false;
 
 	/* Scoping is not supported by Landlock ABI */
 	if (!(ruleset_attr->scoped &
-	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL)))
+	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL |
+	       LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET)))
 		goto out_unset;
 
 	env_type_scope = getenv(env_var);
-	/* Scoping is not supported by the user */
+	/* Scoping is not requested by the user */
 	if (!env_type_scope || strcmp("", env_type_scope) == 0)
 		goto out_unset;
 
@@ -254,6 +256,9 @@ static bool check_ruleset_scope(const char *const env_var,
 		} else if (strcmp("s", ipc_scoping_name) == 0 &&
 			   !signal_scoping) {
 			signal_scoping = true;
+		} else if (strcmp("u", ipc_scoping_name) == 0 &&
+			   !named_scoping) {
+			named_scoping = true;
 		} else {
 			fprintf(stderr, "Unknown or duplicate scope \"%s\"\n",
 				ipc_scoping_name);
@@ -270,6 +275,8 @@ static bool check_ruleset_scope(const char *const env_var,
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
 	if (!signal_scoping)
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SIGNAL;
+	if (!named_scoping)
+		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
 
 	unsetenv(env_var);
 	return error;
@@ -299,7 +306,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 7
+#define LANDLOCK_ABI_LAST 8
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -325,6 +332,7 @@ static const char help[] =
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
+	"  - \"u\" to restrict opening pathname (non-abstract) unix sockets\n"
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
@@ -334,7 +342,7 @@ static const char help[] =
 	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
-	ENV_SCOPED_NAME "=\"a:s\" "
+	ENV_SCOPED_NAME "=\"a:s:u\" "
 	"%1$s bash -i\n"
 	"\n"
 	"This sandboxer can use Landlock features up to ABI version "
@@ -356,7 +364,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-			  LANDLOCK_SCOPE_SIGNAL,
+			  LANDLOCK_SCOPE_SIGNAL |
+			  LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
 	};
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 	int set_restrict_flags = 0;
@@ -436,6 +445,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7 */
 		supported_restrict_flags &=
 			~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+		__attribute__((fallthrough));
+	case 7:
+		/* Removes LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET for ABI < 8 */
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
-- 
2.52.0
