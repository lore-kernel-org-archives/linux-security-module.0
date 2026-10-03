Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD33284B4F
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995914; cv=none; b=pJElJ04LT0USt/K7jQdlaFtty0RZaEUr/aANDfQCUVHAL4ZeDAkz33QGc2sWqCjxKHLJbJ6zn6JR27pdlpewvHLyt4tJW6gkVOrjHUUqCO3pVfifocGfZmxkko4Zhnuvx2m0aoqNK3aQDSPBAZvjI/bDpEnzFvw/NfQKOLhZmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995914; c=relaxed/simple;
	bh=DW/rphVlHqoSyZP0Y95DperspIqfazErgIE52wIedT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqrewkY6MU8/cPrl31h+5FWEiuS7AJxpto2GP5+1jCkhyp+q1YXRTfA+CD+sNqgXaiNvERzznHnYjoCzORCExA2hTsRmRM3+6jVdaa88grrtt8sjQBbstZAUOvK5ffN2DkPOaChL0GeBrK4rry/rTT6NKU8sDKD8m25/+aNpHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4yAQPdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4yAQPdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084C41F00899
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790995913;
	bh=VtCeP3N59kBDmB9GY5nRpPv853a2zVMw2oYn8y2WK4s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=h4yAQPdCmpZLeU5JT9BgJZrApuyYV3OXQ6k7JBZEkpC5P6U4XN3PjcRit8HlWB1oj
	 dge8EdJUc1euaNWn3cd+aOtxXtyIwMIe50NK1e2Mo27TezgI8mUfvoRrEXIxYgWx30
	 QNbFH2IQIFT4ojYXhKeUnlHKoXaBUabcgr9yonOPu3uBar6CrR6EpI+/O+/NLS5M3V
	 ASSDyFdmkIDf4DOakvJ1HUmE0ir6j65n+5kAaGyMV3CUky+KkSDEFJG0TnMRHjNjry
	 +ZDJ+7+rnOmzwMCV+9IjAQd3zXk+jOHOb5TawqjyRm8hAaYW7JoosIkAoQpKZ/0Zme
	 eER66/8cW4eVQ==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Subject: [PATCH 3/6] ipe: check parser token table sizes
Date: Fri,  2 Oct 2026 19:51:32 -0700
Message-ID: <20261003025135.3666767-4-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003025135.3666767-1-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parser token tables contain one entry for each enum value followed
by a terminator. Add static assertions so adding an enum value without a
corresponding token fails the build.

Assisted-by: LLM
Signed-off-by: Fan Wu <wufan@kernel.org>
---
 security/ipe/policy_parser.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index f1c05e53667f..309a61594e1d 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -128,6 +128,8 @@ static const match_table_t header_tokens = {
 	{__IPE_HEADER_MAX,		NULL}
 };
 
+static_assert(ARRAY_SIZE(header_tokens) == __IPE_HEADER_MAX + 1);
+
 /**
  * parse_header() - Parse policy header information.
  * @line: Supplies header line to be parsed.
@@ -240,6 +242,8 @@ static const match_table_t operation_tokens = {
 	{IPE_OP_INVALID,		NULL}
 };
 
+static_assert(ARRAY_SIZE(operation_tokens) == __IPE_OP_MAX + 1);
+
 /**
  * parse_operation() - Parse the operation type given a token string.
  * @t: Supplies the token string to be parsed.
@@ -259,6 +263,8 @@ static const match_table_t action_tokens = {
 	{IPE_ACTION_INVALID,	NULL}
 };
 
+static_assert(ARRAY_SIZE(action_tokens) == __IPE_ACTION_MAX + 1);
+
 /**
  * parse_action() - Parse the action type given a token string.
  * @t: Supplies the token string to be parsed.
@@ -284,6 +290,8 @@ static const match_table_t property_tokens = {
 	{IPE_PROP_INVALID,		NULL}
 };
 
+static_assert(ARRAY_SIZE(property_tokens) == __IPE_PROP_MAX + 1);
+
 /**
  * parse_property() - Parse a rule property given a token string.
  * @t: Supplies the token string to be parsed.
-- 
2.55.0

