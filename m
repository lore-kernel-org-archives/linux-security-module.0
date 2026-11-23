Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795393907;
	b=F7P8Rc+g7fXmQ1izL+b/zed7nqgOy6N97k4DqTXvpWeCR0VBQqSpT2Y3Br/QRFDGrwtA
	 lFbUpTkVII/uwk8TrVBzJ5tku99KeVCo0Q2msqCvExrfVWz/9pKeIERsD4N6kRYrQypBD
	 Tk/KyndQQKQqJ9M6Q/9PlfZdExHly0LpMuwjVUwhELSxtSRwrkjUxl8rLb9//bemdeHXV
	 MSFqwM8bvnxblH8MO1+qYQOxtKiFLqcLx46cSXk4j6pPeS3ZPCyiYLZJN83+rZLwaGqUg
	 VTAqgRsRYvP1+aSyR9Y6Ppq/bWoHwbmDMgtmHduG36VP+omDeDzuaqlFQawpjgFjkMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393907;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=BeHk85TjcCNnd3naREJ0w1wMPb08Z9jIC+l2HRGELtY=;
	b=K7fDwk6jKmAqijK4kJfeJopVf7ZM2h3wYPVR+prv43psmafDkfs38+W56qZjioBWutmr
	 Uw2TffuIkliA2zskprkF4hyqhowrd6SZeIE1E+ObRGFVyTEhYQo04KP+d4JvhEpkbWHg6
	 T7ApOAhS5VfkrlWtedRaNQF+A0JGWecibyd9LTWLkK0PXGJX1VqBovD8GzvmEGGbKEfbM
	 U+5mJUnv+dsPXrNiHaIU11d+PSxqvKeypzr8HT+UtD2dO/jVd2gsmtg/Lknv5a3c3LLh9
	 GrGX9hnYIyODO/Qbx0TL/+mxlyqkbH3SxxmWkePzErr1RUg1FAFxfxlwKEfSVkJbMZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXP738gS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EC606A31A;
	Mon, 23 Nov 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXP738gS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795393906;
	b=uxQKsHn6hfHAZpAQUXKAfNKYZGnOdcsiLv3nIJQR3vPGbk0nRB9Rsx+UNFnLPHtiXqBZ
	 baxAZGjyTX6w2nLd87sn67sGYX7Z2iTSxBuhyrJEAyyHLm/IJVVWRfkX2FdF+nm2bb5So
	 Boiz2CBfHwbNeoKOz/5K2+0QZm+G4078MGmK5erlBYkY/NpZLyp/bty1dW5koUBGj0fn4
	 gycoMC8ip504jSzGDplq6d9jHiZ6NqDQWqjTSlGhd1gBHiHqMAcD13d3WwXwiYxJgnRuX
	 MnCJrQnSfWOSaDC7IQjn2DaF+hWAWK/LqDrfZTH20BGUIt4Q4CqSb5lmUQ6pI1aEtcQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795393906;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BeHk85TjcCNnd3naREJ0w1wMPb08Z9jIC+l2HRGELtY=;
	b=jj6DcbUcYj+1BAltXdAF9RA7wAMTc3EfyCpmuIJQ1ZeBDTew4qJwasvA90J7I+AVwPZN
	 umNZHSuRPfrmpIkVbD/2TH/ln/BNrg8JtF9uA2ys3L9fAKtjKvRTx8kJBmsz7skjzuXtC
	 4e+BpUsOPSThce6x/920Vv0Fffoee23qiJrTBuoq7uFeZ5ClRvFNZbEYxftR1acfLyFt2
	 AboLO1yyk/XA38dBQA3f226oLujiCzcQkw7rtVxkRpTh9WRaJAmuCpetaidEEk4NI+Jyf
	 HH1URU7ASyEUrPrFdVGLKXiyV1EGdOBecAf9fEo3dyIXQu/+VjmabxXC0wbBbKeQsPg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3B10D1F000CF;
	Mon, 23 Nov 2026 00:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795393906;
	bh=BeHk85TjcCNnd3naREJ0w1wMPb08Z9jIC+l2HRGELtY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=BXP738gSnOHTcWFltqYFLnH3FwV7XfUoa1BUdb3NVJr6IrAKNQ1ufyD5e47SBXL+q
	 3u6ezBWVAudQWWQH08py4jEBMhUp5OvKvN0OBnoiHGBEZ1wgRcmTUGB0R9dr6M9V5v
	 k2vGn3irBEX9eZwMmWqKA7O+YqwoXvD5BAliWFab+EQWFMSQ0SSMZZlMauVtws5qmX
	 kvKqDe4C4K5Lga6+Ad8A4FpAcDkQ6+YwPPUZdDHtFim+dLEoqQhrzvSzCU+KGojfd9
	 GAbxyWDetpo+q56yLNFBtKBH8lfXkn3FeFixRhKo02+8vMvFhjypFWD0jljdgwym4p
	 buS1p37Lit+6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 848154C250;
	Mon, 23 Nov 2026 00:31:20 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 00:31:20 +0000
Subject: [PATCH net] net/x25: inherit the listening socket's security label
 on accept
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-x25-v1-1-4432d3892f8b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFeJA2sC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNj3QojU11DC7NUM3PjRAtDoxQloMqCotS0zAqwKdFKeaklSrEQweL
 SpKzU5BKQfqXaWgD+ODVGbAAAAA==
X-Change-ID: 20261123-x25-186e673a812d
To: davem@davemloft.net, kuba@kernel.org, ms@dev.tdt.de, 
 edumazet@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-x25@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 paul@paul-moore.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795393879; l=1370;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=XGoRm9Gpljgv4Y+6YNOH8RsisuTKbd1tc1zo4DvuC1o=;
 b=hnXxtrPN9egbQpZkz6j8eAD4973y57RXC/IPXVBw3HgfYsXcxTW/dYanVAypab2fkZJf5DoEk
 h8c4yugbM3IDu8UzdmiOMbP2e90i/qZPKMxaMYYZdoRsRIPbNtdc/qi
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

x25_make_new() creates the socket that accept() returns by copying
fields from the listening socket, but it never clones the listening
socket's LSM security state -- there is no security_sk_clone(osk, sk).
The accepted socket therefore keeps the security state that was newly
allocated for it in x25_alloc_socket(), instead of inheriting the
listening socket's security state.

Other accept paths (bluetooth, tipc, vsock, iucv) call
security_sk_clone() for this. Do the same for X.25.

Found with a static analysis tool and checked by hand.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on x86_64 (W=1, no new warnings). I don't have X.25
hardware; the fix is by inspection.
---
 net/x25/af_x25.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index f45c9ec7d2c6..802688d5ad56 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -598,6 +598,7 @@ static struct sock *x25_make_new(struct sock *osk)
 	sk->sk_state       = TCP_ESTABLISHED;
 	sk->sk_backlog_rcv = osk->sk_backlog_rcv;
 	sock_copy_flags(sk, osk);
+	security_sk_clone(osk, sk);
 
 	ox25 = x25_sk(osk);
 	x25->t21        = ox25->t21;




