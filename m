Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6916F288
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115267; cv=none; b=MHKPl0vuw/qYrsUZUPjWron33biyfG9GjErD9zpYeCySL4g13CYd36GkyJ6mxb/AgwBEPGJzeACkoqGAFXBEcvoY/h41yaaawBPF0zY5naM+wYt0ykRhhdjfYWii5REpUjJXG0zbDr2Ut452MWb6xXgzcffjxSHC4kZg9yLGYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115267; c=relaxed/simple;
	bh=5n8xp/nqWH4U1sv1lktfY9ahJB6GbUq1Id12x8oOmAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmUsTRkd9eVxiyPz+37riW3jzBYkkq1tJ3SjEu9EbcB18pzIWFkGMSUcfyTFf/pNMK6k/M5pPGHV9seIUxoD6s2vCSZA6y9dFyNv7RWUV4iuLEhXfSqopvBe18mafmXBzqH/dAGDcEzdAMS4deYpXVndb3UTGbyXJmgKi1Pgz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=jUiQZXqg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ya7e9CKi; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="jUiQZXqg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ya7e9CKi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA3A27A0084;
	Tue, 30 Dec 2025 12:21:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Dec 2025 12:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767115264; x=
	1767201664; bh=R6uoPf8j0Zr9XvB46v3Jo/5i6nNHuFNIIh2cSxhJAIM=; b=j
	UiQZXqgz8SORNygSV70iNJEfdgQ+52uJnuRs6PVnBsr462vPFXgAjCGz/kke96kC
	Lo1eXecxZmEU6b7tDxOB2vSQhX7LShCiX9qNnYF/xOtm2ucePknPjV2t6if0rFnR
	XHTiUI4zBSZjB0iCzwCJfWy0DjRW7ccUsmz2uMWHFZSJ5Wx+CNJ8hgDXGMjdQxPp
	I0ka7zPi+tpuY8KFV6/9r+3cfJMW0ABqVuot3lSdlvUXxcTpbG0b9vtmjDsY+XwL
	NWfofWDFDQbNlW6k98xRPe5vJTcupYvDSZEWWfyNLOd//ILSfzqs61hOLLoaOpeO
	/iaN3+PVcUfE8ACNL/Kfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767115264; x=1767201664; bh=R
	6uoPf8j0Zr9XvB46v3Jo/5i6nNHuFNIIh2cSxhJAIM=; b=Ya7e9CKip8g0V2YPP
	qHjYFC21zu5KCr6iLkFkr0+6nVK0Rnv4RPqQ39DM7/qYdE1k0rW4DxbOIayy+YBd
	kZgg8RNzUlzrNTJ4nRR17Uj8gIQYnayM0OK6UWMjZwPspv7in98Jh60WO5ISMyMx
	VwYpbXDzU9Q1lgoUpRjyezAnkp5eQfybSDciCrCF7y9n7Yw75woetTOqkiGdmkgR
	56pRUDpq28Nzkumwvuh3xij9jMrpsgAC9A1nrEHonaLsJuDildH/OQ+WZlfI2gkf
	GVtc6cq84SCvDl9MQ0EAdmGHk9hZjlEKgiA0ZxQb4C/6ABfnykr2RMKWgQe8GhUi
	0OMPA==
X-ME-Sender: <xms:AApUaSGIG96WletLJNw86xlN8nTCGaAyDgL5vwEakZ_pcG1eiCWVgg>
    <xme:AApUaV58Jp11fESDwQc2ub9e0WFwNHPF6pXyufWQgs0Rk4a-VfNyr33l6mTwYkQku
    75dEXQpqGvQ7F-WsUMs8Xf087KmMmMOaByR-wjDmmMbcDCuuiiigRI>
X-ME-Received: <xmr:AApUafw85S7UZcHZNOflhPdeZ-UEQJcCEo8P2HUDmavp8Ije5goTREI8QwGOsE0vvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegu
    vghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhisegrlhihsh
    hsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhtih
    hlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhs
    vggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AApUacMUQrpSi41tZIG7rWU5RpbMJjIKlbQi5o6T_ncg3fzGlgm8xg>
    <xmx:AApUadk4Dmx4hTa4qOO_GlDDoTdoESgTAq24j_CE-vD2xMoN0MkFgA>
    <xmx:AApUaZTgznCFQzDwyZCPL-hrorseXUs2U9Xi_TWKIFsVQlI85s4UaA>
    <xmx:AApUaUWTUQ8GdisMPD4tTeHpCO6nnVg0BTaJ-eke_N3VGeCNkOAKbg>
    <xmx:AApUaRz3AytyjGqEmiqoyULoahJDN5QY-UrxlvRxix90QSMwnOzBcj5r>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 12:21:03 -0500 (EST)
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
Subject: [PATCH v2 3/6] samples/landlock: Support LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Date: Tue, 30 Dec 2025 17:20:21 +0000
Message-ID: <5e9ac4104e5f70cdf250a3dea9a553a65a36fff9.1767115163.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767115163.git.m@maowtm.org>
References: <cover.1767115163.git.m@maowtm.org>
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
