Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB2381B8
	for <linux-security-module@vger.kernel.org>; Sun,  2 Jun 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717330395; cv=none; b=HGLtl3QBq0rMS4zm12zMR29VFvERiM55k3LO2QMwWLxWM+WJqQYWus0uBotRzX/HHdKXBQohrYaNueq9a96S9grerP6L/lNxLL5D6sHJws2vScS6pYrn5z213IV5+EZ0x51/BOgQ2u2xeMKDwdmZYB1dX1feyzCRllvD07AZzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717330395; c=relaxed/simple;
	bh=4o3d8kCL0il1WUfMIRaScf2hNYxw2URkg/tDazov59A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Plxn6xZRwymaqTKYQuWdRGsEZLn23Wj1H20jiiZugSK08uLvlnJKEsXGdCuo/KDCsqFiKcQCH2dpp+5BqdVN5Sm8NZIpIbW83/9ezAvW0PO7Y5b5IiJ5rr3g+q6zua6AdA3DNVCnC7KXycUbRp/mi1x7nYqjFZg2bTkbOe9C358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=R5OjOr6q; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="R5OjOr6q"
Message-ID: <39aba268-8341-4644-9d70-71ed91c7525f@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1717329974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZDT4b57y9roa6OE5GaCrTx6QD+x4jnyI/QdwtJyJgtg=;
	b=R5OjOr6qkqAT5mBK+Ci4YRxLB7njqKKP39tTsU6DoSJ3qDXgA8dZbgMZS6v4s98VejcKu0
	j/W+HH6V9DjcEz2oVAtb6D+8aA/Q1yR2ZMrt6lQlj7U2oW6Peo4YcWuxAuf6j0HUJ8DxCK
	xp+qpaBBW4lGYFbf72XLD6qFHwC4i1U=
Date: Sun, 2 Jun 2024 15:06:56 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Konstantin Andreev <andreev@swemel.ru>
Subject: [PATCH] smack: tcp: ipv4, fix incorrect labeling and unauthorized
 writes
To: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2024 12:06:15.0909 (UTC) FILETIME=[45018950:01DAB4E5]

Currently, Smack mirrors the label of incoming tcp/ipv4 connections:
when a label 'foo' connects to a label 'bar' with tcp/ipv4,
'foo' always gets 'foo' in returned ipv4 packets. So,
1) returned packets are incorrectly labeled ('foo' instead of 'bar')
2) 'bar' can write to 'foo' without being authorized to write.

Here is a scenario how to see this:

* Take two machines, let's call them C and S,
   with active Smack in the default state
   (no settings, no rules, no labeled hosts, only builtin labels)

* At S, add Smack rule 'foo bar w'
   (labels 'foo' and 'bar' are instantiated at S at this moment)

* At S, at label 'bar', launch a program
   that listens for incoming tcp/ipv4 connections

* From C, at label 'foo', connect to the listener at S.
   (label 'foo' is instantiated at C at this moment)
   Connection succeedes and works.

* Send some data in both directions.
* Collect network traffic of this connection.

All packets in both directions are labeled with the CIPSO
of the label 'foo'. Hence, label 'bar' writes to 'foo' without
being authorized, and even without ever being known at C.

If anybody cares: exactly the same happens with DCCP.

This behavior 1st manifested in release 2.6.29.4 (see Fixes below)
and it looks unintentional. At least, no explanation was provided.

I changed returned packes label into the 'bar',
to bring it into line with the Smack documentation claims.

Fixes: 6c3823bc3abf ("smack: Set the proper NetLabel security attributes for connection requests")
Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
The patch is against branch smack-for-6.9 at https://github.com/cschaufler/smack-next
The hash 6c3823bc3abf is against git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
The commit 6c3823bc3abf is based on 07feee8f812f, which is available at `smack-next' repo,
but 6c3823bc3abf has much narrower scope, so I point at it, not 07feee8f812f.
This fix passed `Smack kernel test suite' https://github.com/smack-team/smack-testsuite.git

  security/smack/smack_lsm.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b18b50232947..d836ca61e081 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4428,7 +4428,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
  	rcu_read_unlock();

  	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
  	else
  		netlbl_req_delattr(req);

--
2.40.1
