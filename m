Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571C48F85F
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404131; cv=none; b=Pbm1LpzoTft4OOzcgE78r4pR5MtFtkDO4MahBlOUgxPdxPEzriLppP7BHSjoSmt6H4VLbqT84XlPU/ngDt5FsVRvsTQI2dksfK8p6gTOEgNPZNpzDoDRuAe1KfiTrlTPq5XOcJXbk7Zv3YCd2+XqdUlrC6XmV8hJaRN9a5X7Aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404131; c=relaxed/simple;
	bh=fyPrl3WvozGTDDVsDO8MGVfKnhRCs2T8g6qKeea9uQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UiB8xLrm8wosYctoj9wB2z/jzWwCU8V1HOADlQ54RJ4QctI151sDJRXRpUbUJilJpMZ6OhFxeOy75WDWMG1mFBKR+hzUAswPVTrXCrF6PewZv652q2tHCVF0+zCuIf0zGMUTcUe5Bo2Fu7u9Mz8QyUC7H1892Dbzia0hlhzLUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=f5lMeVgu; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="f5lMeVgu"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-66fd0af9eb0so1249834d50.0
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1789404124; x=1790008924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndMM0TFrryHnZOvHnxhOWJr9tGmJVwIhyX6o7UKbX40=;
        b=f5lMeVguGh1mH4Nna49X7IZNiBsDiRwwgHAAwhJRQY+ZByij2jyEx4lsK54K5OA2+e
         jFm9UiDUQT3kDyC5tHE/XGiNnorfF2b4xKZPEvrPqNyY0+M2Hgz/zCdPva7/qr/9dOOm
         UfQzb0QXf+wLNVjOK6HTBvlVi0SsMFokmKKGN5+bduK+hDLiRorkhsn+7G7qYXHj2siE
         beLXJ/xcGk867HZ5ZqoElH6M34ATJo2y9mFIG4m878j12sup1h1i0S/LryjR/yf3yBHv
         LLAqBHUl72QrDEwXVRhWS0cv2jeK0+wGMdBDFwu3ZMOQ2VNx0SBCK4ibsE4f/lm5Ur4n
         6cyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789404124; x=1790008924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndMM0TFrryHnZOvHnxhOWJr9tGmJVwIhyX6o7UKbX40=;
        b=tMlXXobXh+f/HU0s6tRLBwgFwliq2kJCGYzDusbMVAvTSiNpRteVQ4lHFVXa5PbQ4H
         QaZh78LLV9GVd5btbKcfqknvesbwrW9hLBh72YA7+WAsSsHT702Xy9CO0ZsmmyRml79n
         TRC2BBdItr4hUpKW7vUllLzKWYZbswAxHJRxcD64WJq209+nXwCPgX1wvGrNEvzCUi6O
         6D1E6GDrYKbu8uI05ncHZ1Zkc+V+0fwMxh/TBeTrbhKjsiILrZIuq+qn5SWJF5QF5Rqh
         A3Yxnje90XRSQglH+DlDn61rmJ5spScQ4nCyK8PcwSNL4cdNeA9Licy/7l6Ky03JLUYt
         FNTw==
X-Forwarded-Encrypted: i=1; AKwUvBz7Kj8O4XSZoKCIQQP8ljVx4YkfEwlUrNHqZ29szm9kfpM6OfJhyXk95F2qcE/c2xIaX9kZz+fYF59vfQ2dlH+qx3dux7c=@vger.kernel.org
X-Gm-Message-State: AFuF++lTCVj0joTKHooSA0/3TfVcV5DOqUg2i86w0/LKDBw1mhLrafG1
	dZ9IL/zC7VNjEwUqNp5CRoBnATYqGdPJfI2RYU1cyXcsBe7qdZfGbNydxz6ejWraOcxI
X-Gm-Gg: AYBFou3RPmZlrodISaCfmtgz4sW0QNk8QeGZfc65U3UxK4y5XGwkLbU25exDsbhaDV6
	FVSr600fQinC+lLJWF49P/j0HEJq+H04UtKifaCAgcNc1CbRYXshcF+ZEhq/WvuWKIsEcg9ijv8
	KOpU+IBU9lEXqa/oXiHaW5C9gPv+Po1HRSl/mnDXJyOUse5fedOP2g4ZtPwQcjmDh0CgDZU928j
	FyzGLkDSSm/lFIqVjSyOHp0q4XOJKSD6vygIcYFT2RyXTfzisUn5c0xqIq/i+lFXTpsKbyVDXm5
	H7X64/8U18SdXrM6VWeiGnIEjmIitQB0Xv8V2YDJY94lOtSKPQt3xSLKPaKJphzECyvClxdgu+5
	XYZnEdxCwBTuXH4zCP8Fm42O1UC9lT1s5hke4WwFSNuyMrDAZjSO40ibYKmTMi8jjnOunnP5gZb
	JrTqccVUprs1uIrr5FeLhG4BPXHTy3ct7c+mAQKuF3BMAVSw+gne4Was+IgB2d
X-Received: by 2002:a05:690e:810:20b0:671:4a9e:7c91 with SMTP id 956f58d0204a3-6714dfd252cmr743318d50.10.1789404124390;
        Mon, 14 Sep 2026 09:42:04 -0700 (PDT)
Received: from [192.168.1.110] ([2600:1700:1ff0:d0ef::d15])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df42a8sm4879023d50.8.2026.09.14.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:42:04 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 14 Sep 2026 11:41:44 -0500
Subject: [PATCH 3/3] Documentation: keys: document IDs added since
 KEY_SPEC_REQKEY_AUTH_KEY
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ajhalaney-dmverity-key-identifier-v1-3-01922dc1366a@amutable.com>
References: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
In-Reply-To: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.14.3

The table of special key IDs stops at KEY_SPEC_REQKEY_AUTH_KEY.
Fill in all the new ones.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 Documentation/security/keys/core.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 326b8a973828..37ed42382f16 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -372,6 +372,19 @@ process making the call::
 	KEY_SPEC_GROUP_KEYRING		-6	GID-specific keyring
 	KEY_SPEC_REQKEY_AUTH_KEY	-7	assumed request_key()
 						  authorisation key
+	KEY_SPEC_REQUESTOR_KEYRING	-8	request_key() destination
+						  keyring
+
+There are also values that refer to a specific kernel keyring rather than to
+anything belonging to the caller.  These keyrings are not linked into any
+keyring, so a search cannot reach them and the ID is the only way to name
+one::
+
+	CONSTANT			VALUE	KEY REFERENCED
+	==============================	======	===========================
+	KEY_SPEC_BPF_KEYRING		-9	the ".bpf" keyring
+	KEY_SPEC_DM_VERITY_KEYRING	-10	the ".dm-verity" keyring
+	KEY_SPEC_FS_VERITY_KEYRING	-11	the ".fs-verity" keyring
 
 
 The main syscalls are:

-- 
2.55.0

