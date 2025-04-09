Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8527C166
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224825; cv=none; b=mqXfmuoJlOEFv5LUissfCmJripwGi55NustFjm9cHIWDtpDZJQ8YU2QKf1PyY8i9TLBpPYivGJp011yS/6Xup/yWi8v/G9ykCoPmI7ONMeDnXVF5zWWLpeNcVC9cq5BeM3eyonkqXRlaIv2a6Ul+rovYEo/ons2hSn3kPXnBjvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224825; c=relaxed/simple;
	bh=J8s0MQCX1rti68StIWFgrsqpocBfi5qZEsksUWpZxis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNsT7i2GxbHOlJ4tkYvpaRJT29lS+kMePzmtHUxFCiEQoQvb6q9gRVcj3TemVMSE3GSxQvoN2l6BGr8Y1/AC65vNU5c4KN46FSMjPkwa012XtMTm54VQ9dIf2DxZOvJDTgIKMaw1OQLOvXWudU7Vjlo/pP6m4ain832M6F533wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d4u5oiYb; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d4u5oiYb"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ed16ce246bso34642176d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224823; x=1744829623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeZKybOSs8+NFkJZkOorGpVfvMZ0pYJDZjai2pWJ8pA=;
        b=d4u5oiYb5SBvHvUMBDPwTcHp5dsXnnhQyvkK+mKqQc3tZvxKUjuit8ZydID7xmjsbj
         ka7vrQ5AuOBA3abOYtz9wjOFYXvpL3+AkWgQlhecSCFesxT4pTOfnOL4cINX8II8tFhx
         y8q/mpN3AWuv3yR/YfUz6X3ucZQ4vwiOcTzSF3lA6Y3FOb4X4KljlIdP5po9kqHVnnzl
         rwgP+lHc2AG3mzOPXw5z/WJRhhe/JwB8K4aBxbojClvqal4edvJ4ddFM3vE1Q6D/pRow
         YvMD3Uf/xwGbwA7OcNdMCJ6fHqQW2tpjmfgjG4wy2Ec2AFM0OSua9oZ7SGf3fLkkAgNA
         vjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224823; x=1744829623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeZKybOSs8+NFkJZkOorGpVfvMZ0pYJDZjai2pWJ8pA=;
        b=Hg+EbspoauZ+VL2ANsn8IR2ATue2s+XX/V1IDG74DS2Rt5BS2EiBULW3f624t159m6
         8Z8JBKOBW+ZLxDs5Z/zDw3bWLF8+1/uPuJTO2vpWYg/MWMxiwUBJ8kWmVr1RXIjKgRtp
         9OtvMNiZfmk+v3lC+HtQwNKcCzkb/DJrEIQvH18OnPH+hxBeNzzrTZDSZgKGRf5puFIE
         HjILLGxPeCuqKmp6zaklEigQC+uO1p5qNy7xiJSO4bFz/kTg5sGNH0tvhB38BhwgyOo6
         VFXDDAXblK7DwxoYcYp+zyHYB8XwpmQM4Kac/yD4LKLM9iBK9wbQZnzVvWA8xbxELPVW
         sHqA==
X-Gm-Message-State: AOJu0YyPK6oADOjZ271N7kgjMcXQYdquzIn9SeU5auxpSRuMZZQ37j6d
	Zv9FwOqzpD+BT+tb7JzpYiE4SxtTK2Mh2uX3Fv+gGO8K3sL1tVpHV7OS6+S/8Y3U9wKvod4SDuA
	=
X-Gm-Gg: ASbGnctvKgxsqugK/zFDDfN1aj6JM3YlrUwPGcNabXMg+J9WkYyF5q0GFwstwXsm7hw
	bkjR3CbxXCe02qG9sXvfaYZNJKwvc2Wfr7Gd5SKjhDfoORnW7W5sQhT4q79n1VmI0kUwFAxvJMq
	CuKXxtQaKUBbhAYkyOKwZDMxjiHEgzkhwPs2/oB1u7ESahco5PFbYfajvv9Wb4gv2fJeDL0vvwf
	e8AZvMzB2hfZ1a/RXsfpNdV1fUphLJ0ku17ek5DgA9ODBFZ7SdNLVX7lnNVDnMxH8yQfK2oj/mx
	rY0VAouNYNVBX/RSEVds4OG5KzXO7BgtVehDq3iHfBw03Zs59P5DCmd/MFC12hIcdOJcpkCtPwB
	GiaByIc621A==
X-Google-Smtp-Source: AGHT+IESHnGzNmRVVfPacCj/vkxRHpaeuMhAwSPmcfan8bf0MsKhilZAB1P0leX7AFd/wHfREf45Ng==
X-Received: by 2002:a05:6214:500f:b0:6e8:fad6:7104 with SMTP id 6a1803df08f44-6f0e5bf7a6bmr258306d6.35.1744224822725;
        Wed, 09 Apr 2025 11:53:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de970d77sm10619256d6.28.2025.04.09.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:42 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 14/29] lsm: add missing function header comment blocks in lsm_init.c
Date: Wed,  9 Apr 2025 14:49:59 -0400
Message-ID: <20250409185019.238841-45-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=paul@paul-moore.com; h=from:subject; bh=J8s0MQCX1rti68StIWFgrsqpocBfi5qZEsksUWpZxis=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sG+swr7AIcKgsrGNx3b01lMOqA9ckaYbHdkB tLPkjbIOgqJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBvgAKCRDqIPLalzeJ c4pOD/4iwZ5xEcGorjH8fqDkC59PW1O43qMZWH+uIU1ASOYZSRvLBdrI9VWc5pmswdaw+LgRNWj 3/4F65Osb4v+kK/qHueTrOgEJLjnhhiDANNtGTrgDRHCRSVSStyACKJCYnpJSgfFYLkGMWegURP CtsszZ/hlTxAI+kH2NYeV01p2H1w/bq2c8zq00xS127hDmPBNJ13L2ZWRF//pdUL2W+ixSAKeFB KThZCVFxS2/4sk6s+LBz6Z/D7D8MsQOPvw1bhVWnQP9Ro6jwKo/sYz7fOZnxraMY9yzgyczCVhE I+JkJ3WhDmD9MWdDPWZIZtRqT+AatuEATTHNaml/tvcEKw336cYdSYz/Yoz5e5StQD/C9rLyDAq YVvdXkJEbYN2zlFOJi7oc9STtDQjEzM5DFzIu8aZa7H5RoeRNfdAEiHr+iIZN25Enx5AWjGXEwu OkYLvDxCS4LyJQJ5sKMHN9g0yPlFaRezAdmxGOAjBKWxNaI5bbooB/Fjt9HAHXh2J84IHctuf6Z AjzQ3WnlfZH3xU7kvRhXhkE6ilZdaJQk/JlDTqWlJAaMigj9O84wJ9BU+6z2bgyLbfqWTAS8KnR dA4T+Ohu5ibbuaAgW18KQRbiQIZda+/B0gA8xQ0ooXUz1vyxM+y18jVW2pT7czR8AyHvrUWvc3S jE9TGSeQuAzCq7A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 55b3fa82db76..04b1f5e760b1 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -313,6 +313,10 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -351,6 +355,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+/**
+ * early_security_init - Initialize the early LSMs
+ */
 int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.49.0

