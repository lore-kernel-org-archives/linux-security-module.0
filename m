Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ajjMHrnB"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B720193
	for <linux-security-module@vger.kernel.org>; Wed, 22 Nov 2023 08:08:10 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-679dc22f2b7so19513046d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 22 Nov 2023 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700669289; x=1701274089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMZcQSe8/fsUp22+IYZRJ6M/E+k7+U8WSOUOy3pE4Es=;
        b=ajjMHrnBzhAvL/ZaGsPokRv9KOagopSjUE/3U1uUoaZqtT/GbtW2EbxEASzWRNc2jJ
         7Na+XcSpszOQylzlbJly1Lty82xyG8GFzuIhDHA0SdbktjV7j1eJSbXnsNxUUL/3J2LY
         98T8WN46Q2EmSBf7ShVc4xCpQEZlm7zuWxwYUL3cSRaldK6fyqavfw6zW6wXhfA/tWPE
         3rznR8xZbL0a1OwAFEElS9E5f0yU3zFGL36PChnOc/oQ9gdhVQ1yI0WpFWSScvvOWCMX
         vwufBf/58+WPaR2YdXpMTuNO4VYnbqvZhb64FBQrYKAOEo4Pfm2DMpToW/gvqWoTf5ss
         34Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669289; x=1701274089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMZcQSe8/fsUp22+IYZRJ6M/E+k7+U8WSOUOy3pE4Es=;
        b=db0spx5HSSx0K79BxBuMybciJi9LAvlBaEs2wBOwQmwGU4epIsxChQMFQmZJXuNxH5
         8K5lCDgj1NB+YGR4etLrRZOEZpB4bfDzUv7HqSyf8/1fYqKvtQ1tHPwj8IwHgV69RpJK
         ZDoKb1QJj7XAZ6pO9vwBeRPS4s1uu4QFZwvmlAXYekLXM7p2VxJQuvM9UNH4Y86E82g1
         DArmhA4ScihGgO+5syrCqKl5PPHvtndhmVDtTJ6XbjXU+PvTpIJJLgj1g6ndVJzsWt/1
         pBAEtaxvAOYAUAETI5zLL0ooclBQM4ID51gkLWAa5qpaGEXHLfUtCCnG6ZLTcr85NF75
         OMHA==
X-Gm-Message-State: AOJu0YxQwY2isG1D1mCyqeaP384MkzTGiSS+aT8cOMnCsVQAPd9ebIF3
	mmWLHTTRqFM1UWZqnb52IF+o3KN68WuIn8VtVQ==
X-Google-Smtp-Source: AGHT+IHW/7vQCnUAAVsFlAUkh0JbKntVcRCA6aMtcBf3X3ziAQDbOGQAlro5c0zGpCRVTiJ0n+Hmxg==
X-Received: by 2002:a0c:b69a:0:b0:679:e956:c89c with SMTP id u26-20020a0cb69a000000b00679e956c89cmr3001361qvd.37.1700669289492;
        Wed, 22 Nov 2023 08:08:09 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q2-20020a05621419e200b00679d8235a60sm3062338qvc.135.2023.11.22.08.08.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:08:09 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Subject: [PATCH] selftests: remove the LSM_ID_IMA check in lsm/lsm_list_modules_test
Date: Wed, 22 Nov 2023 11:07:43 -0500
Message-ID: <20231122160742.109270-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=paul@paul-moore.com; h=from:subject; bh=Hvy1u4AdeFJ73BlVWNdC5bujiLNI9i9FD1ZdWnFz7jU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlXidOzV5nrgr2Yrzj4BupqC3wR+BsnGQH6hISO 9rwZ6C5vMKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZV4nTgAKCRDqIPLalzeJ c7PrD/48QF/IGYc7Vl6PjBtvM/iYM0DIQpFvKMNjgFT/eQhLgIDmTT4mbf3b85pvQNgA5EXvqfX GeNEdV/OyIeIlYCArGa2DFGM1sz3r1GHIJmtN1xFbriWP9z+Y7j6UGZVrip6WrhLakO4OK2nZKU Ynn7GPza2xyeW2tllb5DVoazSKUmWOCVLlreRCwcXsGJTjiOd3xQIyS8iRZFbbgYJK9SR7NkQ/g a6ZmjBpA9/UidIeBjSvHf0jFTP+CBr4Df5q5joD+ajSohJCGc800f/Fc2QE6K76Z344r9RMoEdX cOSuJ5SlQfSfGK6y4uJH7fLR6FKv4fqpkbisXYyY0aNwJrS6xL3URj8msseY2AWYuf6E6zPQ7aB XSlK8UsRAbNzDHF4TaeZItDPQeDwAcAqhyCNwbFl/enBofHP6I3/gXyO5nVripJhu9eII7RD161 vMg0sJFFgLe5fYQbemwhCesqZMl6TBcnVxCOhSCj1wds5ZMURK13V/oiToD5MaNrArzLRdh4vp8 jemlEaoYdGUGKoPHqcRHWXi4Fi6Bo8dTbRliRuEEaRDeJX7E5On37biTOaiW8eFjtfbpYkwVPMt fUtUgAs18vYt/0gVN/05J4BQvwaHrzE9xrooaAwcr7CSnINxxPwYr0eCEJcjaoJR9Zz1txBrxs+ zlLALEGzHFXYn/A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The IMA LSM ID token was removed as IMA isn't yet a proper LSM, but
we forgot to remove the check from the selftest.

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202311221047.a9Dww3vY-lkp@intel.com/
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tools/testing/selftests/lsm/lsm_list_modules_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 445c02f09c74..9df29b1e3497 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -101,9 +101,6 @@ TEST(correct_lsm_list_modules)
 		case LSM_ID_TOMOYO:
 			name = "tomoyo";
 			break;
-		case LSM_ID_IMA:
-			name = "ima";
-			break;
 		case LSM_ID_APPARMOR:
 			name = "apparmor";
 			break;
-- 
2.43.0

