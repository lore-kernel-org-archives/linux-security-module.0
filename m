Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9E2192EC
	for <linux-security-module@vger.kernel.org>; Mon,  2 Jun 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871740; cv=none; b=j5riyuCSq2WCBTp+htV/j7vQg0ZfbK8VlPSq5oItrYC31XHsDJ/dWTUwPf5NcIBnkGE4fyMmTIGPy4Y9nuBj9JXC5AKKXAF6o6AF+kep+1Alrx9gjxo0MaUxwKXrg4lW3zHQOz4v8nWIP+TvtuzlT69GQVwu3XvVLDrZymqqQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871740; c=relaxed/simple;
	bh=F1CMJW78hxtBtMHrcZt/0BLbo+M2N7xtS5R/4ERe0CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amDYXJN+luekcWNCrPo1p+y8TG7gBQqUyNhu+Ao6AaGJ8XbPloBc6SigKia2A1UdUgCEPMmdPRIiJjx63togJAJ0akCoGAjAi515g8UoqtJFlql0T/qSaXiwIwDcDfLfpLwp0sGFxoF92ir6fPoNt9QFY6x+SeqpeMYKQmHYMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=lhQLSqqC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NO+dFdRt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="lhQLSqqC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NO+dFdRt"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B6731140104;
	Mon,  2 Jun 2025 09:42:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Jun 2025 09:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748871736;
	 x=1748958136; bh=JokoAhP/PdstcRC/CHMPGXdblDA2dtYcoKnU9rsoFoE=; b=
	lhQLSqqCjoQ4YxsDakqZpvI+MR7m21thgWwCxCoO08HNWejQ2oc1LpiIED4pcQYH
	jB6IlMLDG2VKzktl0L+Uk23dKF6SEeAQZikiYd/WoFzbJG5y75xBjEhp2iNsHhRz
	kVZAIe3dScpk8Fs3FDWAXhcRP2vCxt/KTSoW9NpLFKLVZ9qsrAvsvO8DE6g6LAFv
	qjw9hFHpf2UHwxXB2xbc6lKY0mwHCnaeNe4xKstOjN3PGEr6/PzY2zhg6DvLKXVA
	aJFVt6QKvkyfzaFtyCHKDgTmtWsnGMcMfwXkFyeqbJ3paS4hegEnaN0vAfGXPGNI
	MopGvmNsUAEohBVTMrwJxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748871736; x=
	1748958136; bh=JokoAhP/PdstcRC/CHMPGXdblDA2dtYcoKnU9rsoFoE=; b=N
	O+dFdRte9ZijbPdddGYQG6uXEJ8pp+tH761qATYnSN88biMKRzwHzX9OtUY3uGbp
	cSIjRjMl35C5WdEly5hMe7EIuEvlX/Ov6AxHEEWU8HW+oeGPCPD5K0NOjNQ+o8ZH
	e6As+VZn84rJDi1deBV5JB7d8vS9yGVW2mjqnpZwiVaDUoLuznGO+vZ4hvZb8zO8
	ChkKjUrP5xMBX5S80iemT+OH0q7DBQSoNpHnYJ939Y1flouxWL+d+9ZEP7xxOvkM
	hj482V+rr7dq5r7Bej/vaFoDBWPJJApPpC8tjgqH7+H/MMCRWkZAWRBnZEjUwzza
	K6Bh6FR2iBjcrLT/K+p1w==
X-ME-Sender: <xms:OKo9aE1k3KP3tTqsaSCc7iJQ2zfArywbUztzPTAG3SaPz0jvWxXX0w>
    <xme:OKo9aPH-5UuCdWDn2LBj4qUydH8FADe3FQ3sXku_7LEMnrNvtF2-M7_zX9N1GeO7H
    8Exl-L0KZsIhunFVOM>
X-ME-Received: <xmr:OKo9aM5qhu-jLUr-C5Kj1FpFgaSKP33TVT4sulM-dQAKFcGzaKlF7__KgKShlje0Jr-PamS-06LD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeekvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeiieeggeehtdffieffhfek
    ueffhefhveeugfdvkeejkeehvdettdfgvdeghfdujeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughigh
    hikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthho
    pehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtg
    hurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OKo9aN35-x5P6RcHWRNe-ZleBe015lhue8Rk-9buZuyiEcRXv7r8QA>
    <xmx:OKo9aHG1xc1bci8mQa3zlOniYnFoAKaMwHA_XrjgR7K1WCzVfCVoTQ>
    <xmx:OKo9aG9jRAF2YExcLv7mDULKH_1uhcU5DB55SKJ4lJk9DJzKVZdZgg>
    <xmx:OKo9aMmhZVrQWPQwoFUN62EgvIB74GZ3LGZxhsFnEZtCRwWfzy6eTQ>
    <xmx:OKo9aGH4y1v8WQwWEiSrCQVC8FMxstBZSeXpNwujgTsEFhNP97LGL9Wq>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 09:42:13 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] Another one
Date: Mon,  2 Jun 2025 14:41:49 +0100
Message-ID: <20250602134150.67189-1-m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20297185fd71ffbb5ce4fec14b38e5444c719c96.1748379182.git.m@maowtm.org>
References: <20297185fd71ffbb5ce4fec14b38e5444c719c96.1748379182.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, here is another one which I found would have been helpful to
me when reading this.  You can squash this with the earlier patch.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..9396d2d9df40 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -714,7 +714,8 @@ static void test_is_eacces_with_write(struct kunit *const test)
  * is_access_to_paths_allowed - Check accesses for requests with a common path
  *
  * @domain: Domain to check against.
- * @path: File hierarchy to walk through.
+ * @path: File hierarchy to walk through.  For refer checks, this would be
+ *     the common mountpoint.
  * @access_request_parent1: Accesses to check, once @layer_masks_parent1 is
  *     equal to @layer_masks_parent2 (if any).  This is tied to the unique
  *     requested path for most actions, or the source in case of a refer action
-- 
2.49.0

