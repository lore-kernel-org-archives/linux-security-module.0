Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5D2FF173
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766925969; cv=none; b=fHn41eSj3ye2luNwE7WZQ+7EuF/Mw/JHtna2cZxKaZu4BRPPGns3wf0WaEjq5MrjSNx0FWH4YEoPrR/qLfYFSooyIT0vanvIPIdSF9tCX7p8pmJoZqhnycDq+Ir3yWCHDdbAohzbz7KrOYqxUNHpSz1kdzl4R8dOzBqvMykNIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766925969; c=relaxed/simple;
	bh=NeQz1u5C19fBpOKG7U7u+Yee9D07LXK7hTrjajsxtVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9V6mAEMdO55QTYFaggttRuRhgUtGH3Un968zCS42xoU/g1NzAGQiXCL7h7HcYQtioa1SUeyleTZ3V5Hrdiw4T+dDJJ0OQur1/Ta2I9Ub/uHP3nhdaRSXsJpSQ8+0J0wkG4YMQ199B2do3T/ZXYwsL81K34fnHUtzi9JO3F5ejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=smkkEB3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=abJJC+lU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="smkkEB3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="abJJC+lU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 23FB91D0034D;
	Sun, 28 Dec 2025 07:46:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 28 Dec 2025 07:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766925967; x=
	1767012367; bh=pazGacwlRDF8CjDkTYtvhCUJNJgRZokq7CX5HNi0aLk=; b=s
	mkkEB3gvII3f8vw0AYcRbW+qh0+/B6eT72hNbAwIahCS95m2Of9xkvOFe+0HGZdY
	/mR3u9i83/OEqFZfxpSB5NHZQU3bPupWay3yQlo1Fdf89d+4stYY4lZd5tH+W8JP
	3KAyeL7X3HUynpQjzKAX6Hd7hVEk2AFzzg3u/XOFvaPBo/TEQ/amU1+DCXXwCCm8
	1XxToelHYoC0fN3IR1+0PzKMNKnQ/EIhq0jP6lTmJwStPucBiWKQ3J8MO7gwESPH
	pwjwBjY62ZBjcEvvQwkRVbaZsBTAVyNIgf6at5+iT5RreFCHQJQBTNtqzphc9gt8
	HFtcocoQSXREaHPkPdvZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1766925967; x=1767012367; bh=p
	azGacwlRDF8CjDkTYtvhCUJNJgRZokq7CX5HNi0aLk=; b=abJJC+lUb6RpgtNW8
	XuRmyws3fpSCm8qGAhurNVtG9CZEVtaF+4tXq9gy/7/AaXLPYFn3knZpGYmDzZp8
	PhUvivqiOIKK55cOZUkb+BhlTwkZ4ZhxjQk7i+a8HV1L+BEeonk3j4Exnvb2TH09
	2q5IIX4FNtQWxOPfZhqA7Tl7lLVCeTrIoXCZTVy+cztF66xHyAlhF3qNhXxRUQ8r
	jJTbRDyYZ1eVvpMcwT4HbfdiLKtw/pCR9B0LG0n1Q8zCDH9YVfpe8/XdGDYRZh+Q
	w0UiIIVqiSTYQIQAI7qj2wRuyLDlge96OAPuR9IHQQNAxCRW6RjQyblV/tNkcbbb
	2OBpA==
X-ME-Sender: <xms:jiZRaQhtUWD0vJ--Zo4-uXqlp_hXeaJkk1k_-BsFzjs1RZ9-sLU0eQ>
    <xme:jiZRaV9ajTEKwTOvqE8RmEIRWG6aMnYLh5OkE648vK2KDxVxGEuRsCkoj1dGkhRSS
    zI81uMcdci1jvv2JP8FQHl0z0178P6hhWP3Myu-YCvcuxftQe61e9c>
X-ME-Received: <xmr:jiZRaTvy3T6DmJs9NHLGvsfd6jArVsr-YOlKGZ7lnzjNUgAq0gqlb_f16ok7Z04F4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegu
    vghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhisegrlhihsh
    hsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jiZRaZqzw8y25oMb_GbwdtHHG2Q9IrOmzK9xHICCkcl0SrHB393kcQ>
    <xmx:jiZRaXrSXwGdbbRza3lGlnHY5v92RzaDwN1bfcIjTsfvn8r_w6FXbA>
    <xmx:jiZRaYaKIQT9HGKsm-ZIFKTqjzI9icN8PePwyFXrnCR9GxfZdpUc4w>
    <xmx:jiZRaV8_-P54ddxUlbLmiP1aycstuoqYCzj1tpnAN7civO7HXjNzqA>
    <xmx:jyZRaYgfZ643Vitlw-H-TRIuxcfb4uCbnHJp1TG5ye3oDDtsYKsQvrow>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 07:46:05 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 3/6] samples/landlock: Support LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Date: Sun, 28 Dec 2025 12:45:42 +0000
Message-ID: <625fa7da41fa6abdebac9e48e824232465504c9f.1766925301.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766925301.git.m@maowtm.org>
References: <cover.1766925301.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tingmao Wang <m@maowtm.org>

---

I've decided to use "u" as the character to control this scope bit since
it stands for (normal) Unix sockets.  Imo using "p" or "n" would make it less
clear / memorable.  Open to suggestions.

Also, open to suggestion whether socket scoping (pathname and abstract)
should be enabled by default, if LL_SCOPED is not set.  This would break
backward compatibility, but maybe we shouldn't guarentee backward
compatibility of this sandboxer in the first place, and almost all cases
of Landlock usage would want socket scoping.

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
