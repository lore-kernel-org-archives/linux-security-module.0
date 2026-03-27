Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D027361656
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630160; cv=none; b=uGsUYgRotUgNIQDOg7BnOzmBKmsHV2+7NJOZG7hhw4wgrtEKgHLvFiila5nKJeOl8X/5m0EfBs2X14WlDOcM5L8nDfiJmCWxmkMcauj7IP0fd7GLGx2D8ucSJaLA2dr//naItvEsgs9GTzO7UOl9HVm95KqRUr0KucW1C2jOWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630160; c=relaxed/simple;
	bh=pqMlMz9fQuXVxlfi9OoB+KzPBhR2LCdq6SwUKsE66Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vs/fcAYo6h54tbq7M3Y+FX9AP+07IKCem6Hd/Gy0IAHQKURANXZyCoiNZxcOVu5oPe36yDDW1CN7k3JfZa6zfEPK9kf6uB5ambc1tLi4K0BoAIwYKmEnQ4DnHs2UJfBP4zHFOJ82JH6UUwZFVpuHGSE5w0rXGbucCFpCN4dT4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT1YmpxD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT1YmpxD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so22248985e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630158; x=1775234958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aQax15r48x8tChpHGKVeKbVuYDhcPcODm0KgJerdHY=;
        b=aT1YmpxDpxxRe/MtQeLeq8yG7MblePxDAC2ah+6VNZDcY+wZAv4UUiaJ4cEnPUQn2C
         eduC/Bmi7JEcTnq8AQdkrlYb4UK2/lCtByXlcP09B+NYBd0quqYwDhnYYCCUnZpQ5r9P
         TACGMmXV0g8eoqhtteOkvRq7Jo49nq0QjZJXm4jY+v/qSiKzjaO2vMQgECOrrw9Bh7c1
         vu3wrWH51dKHFrXfKIJ4iXTunVm+a0wss7zbKxIUZuLAekrS0BoHSsUj++Oj5Srj/6B6
         gj70M+yh9qcOER6NIEfwPxUJSioZsUuSArEAmebreBt3YYXBzdBxmT48CJgtmu2AZFWY
         V3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630158; x=1775234958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2aQax15r48x8tChpHGKVeKbVuYDhcPcODm0KgJerdHY=;
        b=ZoK32qcjPqUhrxeMVtcIBdhgchLROuEFhjtf+v+uj8ajRz+pU5JzivqmLMwAPJ6WZo
         QeKLkvB4ffUg4jUFUqkmL1JCZYvUH7Xsk+Fm52AX0blnW+SDQKXdOBEUQJHTWEhTOuxk
         nvN69zSjh01BOhchoGvb7hXi0SOcDg4VS0YZ3gaS2p+BPOZPwQuq545DKYniaHud9wDa
         luM+6qBrbUXdhRGyuTrSB2VdyJuE5eg0H3+dIdGxWaLUiGgOOe5QmeyKp04lRcuucExE
         xlaLk44FXqaFVeOn4zxqB1pKua9g//vqBsUs7efZgCH/zVJ0RbOx8sP8yKZtjwO6DnHC
         iXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoQC1f3UT8Q8Nci0OO6WRrDaNV7sdTohI5i6qKQdi1HHX4ilKtqOn2ypGLWE9WlL/JCw0kZjgNTfc6MRlpKKKowLYZGAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuiCBf/awp3DxlT+tKJ2Q1JdlXtjKxJ2NFm6vVfxjjAGn7KZdI
	KehRZdh7uvnY853IAoQbuBUFxQ4m2K1Yh9qni8bU03+OkrBCcJ7tJS4W
X-Gm-Gg: ATEYQzws5egQDI/3xjMYup+bCGHlbheijfti7xJgRcRV+HIILYeWE4zRWnd2Xmbm8Oz
	54mkRYax1ayKjzgFD7Hba9Kbvb3I40afrqdsRH2HRcUpg0KbHwCI5RxjZuF9Rol5LVIwwLuXBCr
	zIGOiqfx/Y1/zBwKppaCL8twVOnhlI1oJRqez55uqr+gATmpsiOFlBpCjGzMDhho+KeuTyGOzpm
	QbbwGIOqUJoWrrYsIBu2sDPdGmPgF2uw6jIit3319K04pLtIVfSiOW9kdtTssc3oh1IlWIPA6Ik
	EpkasmaEMJrkWEgYNjKI4CUaF9UqRddQ1jjefjIX++BxX1qLn8GGTDMqQFhJAHxquxbfzUIm0sb
	HKQOwuaucJXipbcYSlRR0znaSf3vC0sCu8hQWWHfVPPFizexhGCcT+a3bOxaDi1VHtWsLkKRuUu
	YWCCkF/NUeczdHqJnr6iIzO5i4zOGaDzwrCIVExYZ9XPY6uAO0
X-Received: by 2002:a05:600c:1d1e:b0:486:fc95:1a91 with SMTP id 5b1f17b1804b1-48727f2373dmr55726625e9.12.1774630157603;
        Fri, 27 Mar 2026 09:49:17 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c8cfdcsm139329295e9.8.2026.03.27.09.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:17 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 05/12] landlock: Clarify BUILD_BUG_ON check in scoping logic
Date: Fri, 27 Mar 2026 17:48:30 +0100
Message-ID: <20260327164838.38231-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BUILD_BUG_ON check in domain_is_scoped() and
unmask_scoped_access() should check that the loop that counts down
client_layer finishes.  We therefore check that the numbers
LANDLOCK_MAX_NUM_LAYERS-1 and -1 are both representable by that
integer.  If they are representable, the numbers in between are
representable too, and the loop finishes.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/fs.c   | 9 ++++++---
 security/landlock/task.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fcf69b3d734d..c1ecfe239032 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1595,10 +1595,13 @@ static void unmask_scoped_access(const struct landlock_ruleset *const client,
 		return;
 
 	/*
-	 * client_layer must be a signed integer with greater capacity
-	 * than client->num_layers to ensure the following loop stops.
+	 * client_layer must be able to represent all numbers from
+	 * LANDLOCK_MAX_NUM_LAYERS - 1 to -1 for the loop below to terminate.
+	 * (It must be large enough, and it must be signed.)
 	 */
-	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
+	BUILD_BUG_ON(!is_signed_type(typeof(client_layer)));
+	BUILD_BUG_ON(LANDLOCK_MAX_NUM_LAYERS - 1 >
+		     type_max(typeof(client_layer)));
 
 	client_layer = client->num_layers - 1;
 	client_walker = client->hierarchy;
diff --git a/security/landlock/task.c b/security/landlock/task.c
index f2dbdebf2770..6d46042132ce 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -191,10 +191,13 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 	client_layer = client->num_layers - 1;
 	client_walker = client->hierarchy;
 	/*
-	 * client_layer must be a signed integer with greater capacity
-	 * than client->num_layers to ensure the following loop stops.
+	 * client_layer must be able to represent all numbers from
+	 * LANDLOCK_MAX_NUM_LAYERS - 1 to -1 for the loop below to terminate.
+	 * (It must be large enough, and it must be signed.)
 	 */
-	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
+	BUILD_BUG_ON(!is_signed_type(typeof(client_layer)));
+	BUILD_BUG_ON(LANDLOCK_MAX_NUM_LAYERS - 1 >
+		     type_max(typeof(client_layer)));
 
 	server_layer = server ? (server->num_layers - 1) : -1;
 	server_walker = server ? server->hierarchy : NULL;
-- 
2.53.0

