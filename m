Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423748D879
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404128; cv=none; b=JD17iasXwkBUDj6Qs+Vwvg3g7v4E8cd0dokXLpUfyHlIEiUV9zVQ7ezDmeIsLYJirH/LLweCi5YGgIlDFzxDeTbbInZWgCujD8j2XmgvGnuOS+B7Er84DrZc6WpLt78R+xb/dxe8vz+XNE91VTo1lSk0Wx8LBDmhamzwf3dEyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404128; c=relaxed/simple;
	bh=H1l4m7LqRJnZ49EJ8tR396A7/0u8ejG0VymqYOqgnNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bAoN9Q6kCimsgp/axrdvn/lu0P5C2zmyZ/Hgw49871LMKdBEs/n5fYIsKl1eBw3PB0jss+sE7evGK/gkg3lwiUwW2BjZp+XVEJ1WOwcP9A0nB/bvzsy1Iy0Nc1LZuF9y5Wis94IChObibKwIEW4ZfJE1ujYXLhuVdSrfXga8UXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=D+NfM3JA; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="D+NfM3JA"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201ebso1880703d50.3
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1789404122; x=1790008922; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OKDUxsVBgyG13X1UZt4eR7O3fTMlydeoVTGRT2zzuL8=;
        b=D+NfM3JAVMqBdhkFR8uFrouOQbtvmwdEK/BblDsiPeia1MBD3YszhT624dIgi7BTqC
         y7QDTzlbwCgCGfGWwfJrI+lzuhU8ncceuex7O1Ijyz7FnytFq42aAJEE5slbbiDxA9+G
         JmnKvb23qGwpYPlp0DiLII1qkRZChnu5vg7oDVty/cHd1q4MQlFFQdRK26HFVcYZogQY
         AYVVKxZV1ngyBVFK23lTZcNd8Le/UWx1k0/U4heT0aSfqy5JG8oegc131+Vs0uKBa/11
         g+f6Bqy1RTEgMjLsa1em4dfCrKmzTRuJ2f8UzRXMNh99Utc0lJjrjFDHAhMKmMKsT8NP
         6rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789404122; x=1790008922;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OKDUxsVBgyG13X1UZt4eR7O3fTMlydeoVTGRT2zzuL8=;
        b=rCOG77yC9Udz0WhNc2fDKRqvVurYeiV/sB1hOHaMHC2Jv8KiKE/toU7pBbSIVebOW4
         CoFD+SO+Dq+xQyh89OuQ/hQt/VuxCBaO0XzA8EFLNCfkIn5NTk+vGnrzJYAdQ0GWF2GE
         qyan/vbl6l4hY5qS+SNMtphX6wq2hPMEmuBspfriKctFXWqvj0HEq4PPZDn4nWeQTnfi
         flBJEKtiOZwmxwWt/6Y+89MnzyioHfZuiQmW+hlC/vGHRO0GCJLF6YKCsm4QP6tXAQjN
         pbsMrCU3E85EadXktqqexzscy91ywF6uBaBvI0ORhfvW91Xu/DA76LQu+pNFGBKqVD1k
         NJqA==
X-Forwarded-Encrypted: i=1; AKwUvBxG4E0u+rz7nSjvxfxzmxCOLwUgttmnSmU/4mACM61jE/N4rBMPUcXA9iLAFbtOTdAPruq5+NdePR7uX2I5mIxitpXnEKw=@vger.kernel.org
X-Gm-Message-State: AFuF++nPEI+BY5Gs+rCmI2SRugUQ4kGHPlvi8uX6M42xLfVs1pMni2Q7
	1XnkFM+mhwgkLmgFwcam+e7tBPt+1XQJqPtcmdIjcharIl1JAk1l7bPg3tfxNvUCWhjS
X-Gm-Gg: AYBFou3Cs0j7rs+XkhFen4sHawWHJTya9kR8e4S74/tGU6BJQrgIJqIOnZjt7ZqlSWQ
	Mbnn2kXLWcsRCe5PVQExntxSDUbQx00eI673n/34Kc2UJ8TUAwcbZ4ELl2YW6B42yj9bnUCkEME
	7bIHLb+Fn8iSh6Bf9W1BU1o3w6xA75rIf2gMMJFKZD6mdoNlUm7nmEzOnLmPD9NuaOnw31oXJiB
	F7JSPfE8Kd7XpNHiSuzxZ7KTYSTUPIL869OFE/XNLf8fb7g+mx0swp7ZG4H7zRaYCru20JwAXXJ
	/8lf+Ls3bYfkJSmA9nX0i212lQkvmMTHr1jDUEcwVr3n1Ay4MBn2JVbaBWj+3BcHeOjL2F1OHKS
	QYGFV+X6lL/52hQ36HSenevo3llbjVnDUXtQ/8/1mk4H5mk+aTPTTpPyc+NCeu+zB+bntxCthMt
	3XftWkuju65Z4jk/YlGF9wVH1/Y3RU0cTOnutdegZfE2/GYQPTq3XD+mENKqz/
X-Received: by 2002:a05:690e:12c8:b0:66d:132a:875f with SMTP id 956f58d0204a3-6714e088222mr1068042d50.47.1789404120256;
        Mon, 14 Sep 2026 09:42:00 -0700 (PDT)
Received: from [192.168.1.110] ([2600:1700:1ff0:d0ef::d15])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df42a8sm4879023d50.8.2026.09.14.09.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:41:59 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Subject: [PATCH 0/3] keys: Add well known IDs for fs-verity/dm-verity keys
Date: Mon, 14 Sep 2026 11:41:41 -0500
Message-Id: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NSQ6DMBBE0augXqclbIYMV0EsTFyEzmCQjRAIc
 fe0WL7Fr9opIQoSPbKdIhZJMgaFuWT0HFx4gcWryea2zu+mZPce3NcFbOx/i7bzxh+FeIRZekH
 k0tyuXW2LokNFujNF9LKeH017HH+y3YXWcwAAAA==
X-Change-ID: 20260914-ajhalaney-dmverity-key-identifier-4187b6233be5
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

This more or less follows the bpf keyring approach, allowing userspace
to easily find the keys instead of having to parse /proc/keys.

Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
Andrew Halaney (3):
      keys: add KEY_SPEC_DM_VERITY_KEYRING
      keys: add KEY_SPEC_FS_VERITY_KEYRING
      Documentation: keys: document IDs added since KEY_SPEC_REQKEY_AUTH_KEY

 Documentation/security/keys/core.rst | 13 ++++++++
 drivers/md/dm-verity-verify-sig.c    |  3 ++
 fs/verity/signature.c                |  2 ++
 include/linux/key.h                  |  2 ++
 include/uapi/linux/keyctl.h          |  2 ++
 security/keys/process_keys.c         | 58 ++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)
---
base-commit: 1a1de54f7369cd2b5bac0f265910e60ad3a6b4c3
change-id: 20260914-ajhalaney-dmverity-key-identifier-4187b6233be5

Best regards,
-- 
Andrew Halaney <andrew@amutable.com>

