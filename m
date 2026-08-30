Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD931F9B4
	for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121035; cv=none; b=LmCwAlaK6hF+avd4XvENEMdEttHfngZvVn4xLcIzwZQQ9YtlwOQsPi6LAHs2QWKH23BWjCxoxstwEO/9cdk1+ayDJmtvGd7L8zhV3wwbsEqrJbCgvU9+w+ywtWn1qFcymEax6xEfcb9JiXHhrEIy2VDik3TDR2mLZuaVdZ4FkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121035; c=relaxed/simple;
	bh=qnBuxHRm0ZKAQlNWrNsQLPpAatqA7MRJqtCeBnPdJco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jI0GNmxRkz8W8yQ5VVGds3XAl5JhsAFrQ1wZ1hk50UqD7vMVs91x4Q3fMjWKkhE5NGZN6sXLnDmojaMCXMPUhTu63RgoeUnPqdK0ZW1GUHUPQhUhEWU2fP2WqS3BOzg0Y+mU/6h6aq8Iz/8MidkUXpGn+ir62U9e0kK2PBNmr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiPjRTwg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiPjRTwg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so31271065e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121031; x=1788725831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WuLxHG99e7u2lGKea2+n10AjWQDCxmpN+ylQ+0r2DPw=;
        b=WiPjRTwgZHZz5gqY9fpb7d4A7JN/czmHcPHnZVgwR2kFcIzPxmrIiUrBqiGuMjbW+t
         dd4VAt2A+KMGsOlqs1wgWPc/WBjcX/bjpTop7H4PjThj3l7St8EJGore4jGYfVHh6ru5
         07aQy4svkk/p0wvX+pnq1hopk30ZMQtYEhU5673HKx9YlOas0jVKcngtGSx8Km2zVfkq
         ZPaJVy3ySPNwJ+kWynSy0oEOmD4cHGreHRLkftQJh+Q7ko0OgmJkqW0NZAqbTRkpbiUG
         c9g1ZLBl3gNMqcpiBcYYN95EnHOSZl0/iYMxvane6XbefOUASvD+bWTrz3QeFgh0J0r1
         iMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121031; x=1788725831;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WuLxHG99e7u2lGKea2+n10AjWQDCxmpN+ylQ+0r2DPw=;
        b=Lu2zgmz4Pse9UIoQrhlwCvOf/jqNuUPUlAT55WjwJyJfLxqmJe086rryO+QYeqFQIZ
         c7LUJOb12wqiuYCnblsYw/NJEagHucbezaHzse6D6x7ywnIQ2DQBVqrV2kox6BtEKTZr
         N0mrD50r4APFQifpTavW07/vUa2sJeUOE8I4izVbo2iSxU1zo7/9s04iXsZBy6+Tglht
         WrAfzcdh+Wey2Ycmusxbrzui+woaX9Wyn0THtOoSl4ZlzjP3RQR/myPAxGjz/8iLEEf0
         Uy3imJyuhPBmjSF+5QJXAhZpkle5gBKWCZjyvpDKhGYFuINb7sYE9H/X2Gcc5osVx1VI
         urfA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9EBWFw0pr4TaMwzAHjrIFgurYg7MuJKim21nqrAHnmDn7utU2mq5x7CHgsIXQtZS4HwuARjN+fL0S7Zc3rk4Rw7RDUhQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k0TxcuiJ5jdlkA9kXvjA6aWshPEByHXhl97UNSt8yCN40a8YpY
	MjFBUHWSzVg1oLhWvxVOArmkTupKV7KV3LnKZ9JAjVjSuue4gTit46+N
X-Gm-Gg: AR+sD11JTdfmlVYZGAZ7cmY9PIAUXwRw2XzR5bob7NgQVBfaOTam7lgseKBG7jv9HLx
	X9w4YfnptiTz8Yr7I47wo8a+CGBWeV3pipc9Wct+Yx1JD2ijun5zBSQpMZPCVDFAmXTegHHqX4u
	qVRwxHLJrKnlQ6151vywiyq0CGVQJpNPOtEAC2peZhcFdk74fwxJiSoX2iyirOT5ZsREzJPkZpa
	pWFcgREp7OjMp43mjOItkuhcR7dkhkLKj7L5T4A7jDXI2VV1CVSaausQrffLIw2wAk4/CgkMHYB
	tSj/FU+nnj9Jp39vXjq4e1QMeQkMy2tRv382ffphAX3thtbpuh2O3LXkGurC708QIo3czkuGu85
	XXy5FAnPqFP+sO7fnKBZeC8u65v4QR4FSWwQ2wcdKWulNdvg737VBoJT8ok+dTxmGuTN/3qtbsC
	kG0PT7CJVYUGkOVVtdjiugXPN0lCjuDl0RdIc8E2Y/NF/WRISw9YYMGQP9Y8Pr/EzLazAVlTuIU
	pMafG112KL2SQ==
X-Received: by 2002:a05:600c:c4ac:b0:499:a5fc:2087 with SMTP id 5b1f17b1804b1-49b91c20e36mr318733065e9.6.1788121031326;
        Sun, 30 Aug 2026 13:17:11 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd2922ebdsm100498265e9.3.2026.08.30.13.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:11 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 6/6] landlock: Document MPTCP access rights
Date: Sun, 30 Aug 2026 22:16:50 +0200
Message-ID: <20260830201650.67050-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830201650.67050-1-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe LANDLOCK_ACCESS_NET_BIND_MPTCP and
LANDLOCK_ACCESS_NET_CONNECT_MPTCP in the userspace API documentation.

Extend the tutorial to handle the new access rights.

Describe MPTCP restrictions in "previous limitations".

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 27 +++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 84cb7bf6b3ed..8bd99430514b 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -40,7 +40,7 @@ Filesystem rules
     and the related filesystem actions are defined with
     `filesystem access rights`.
 
-Network rules (since ABI v4 for TCP and v10 for UDP)
+Network rules (since ABI v4 for TCP, v10 for UDP, and v12 for MPTCP)
     For these rules, the object is a TCP or UDP port,
     and the related actions are defined with `network access rights`.
 
@@ -51,7 +51,7 @@ We first need to define the ruleset that will contain our rules.
 
 For this example, the ruleset will contain rules that only allow some
 filesystem read actions and some specific UDP and TCP actions. Filesystem
-write actions and other TCP/UDP actions will be denied.
+write actions and other TCP/UDP/MPTCP actions will be denied.
 
 The ruleset then needs to handle all these kinds of actions.  This is
 required for backward and forward compatibility (i.e. the kernel and user
@@ -83,7 +83,9 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP |
             LANDLOCK_ACCESS_NET_BIND_UDP |
-            LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+            LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP |
+            LANDLOCK_ACCESS_NET_BIND_MPTCP |
+            LANDLOCK_ACCESS_NET_CONNECT_MPTCP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
             LANDLOCK_SCOPE_SIGNAL,
@@ -140,6 +142,12 @@ version, and only use the available subset of access rights:
         ruleset_attr.handled_access_net &=
             ~(LANDLOCK_ACCESS_NET_BIND_UDP |
               LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+        __attribute__((fallthrough));
+    case 10 ... 11:
+        /* Removes LANDLOCK_ACCESS_NET_*_MPTCP for ABI < 12 */
+        ruleset_attr.handled_access_net &=
+            ~(LANDLOCK_ACCESS_NET_BIND_MPTCP |
+              LANDLOCK_ACCESS_NET_CONNECT_MPTCP);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -834,6 +842,19 @@ with ``LANDLOCK_RESTRICT_SELF_TSYNC``, no_new_privs is set on all threads
 of the process.  As explained in the tutorial above, leaving no_new_privs
 unset is risky even when Landlock does not require it.
 
+MPTCP bind and connect (ABI < 12)
+---------------------------------
+
+Starting with the Landlock ABI version 12, it is possible to restrict MPTCP
+bind and connect actions with the ``LANDLOCK_ACCESS_NET_BIND_MPTCP`` and
+``LANDLOCK_ACCESS_NET_CONNECT_MPTCP`` access rights.
+
+Because MPTCP works on the same TCP port number space as plain TCP, it
+is recommended that rulesets denying TCP operations should also deny
+the equivalent MPTCP operations.  In particular, a listening port
+created through an ``IPPROTO_MPTCP`` socket is compatible with plain
+TCP clients as well.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.55.0

