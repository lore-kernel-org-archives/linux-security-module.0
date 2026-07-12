Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73F2C0F6D
	for <linux-security-module@vger.kernel.org>; Sun, 12 Jul 2026 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820719; cv=none; b=gnudVLq6iShJrcHDXrfLgZ6DfQFLsSY3KwOJksviRds07N0SgoHNQ5+LD1TyvE44EftHt3Cbz/SCMlSVvNfxxCKFoEvUL/BIoAg/MUHvQMpiKk8wiDDaM+VAuJ1ui8p7UCDiJrfvwFWgxt/ZqAgpvfLed9B14wxiYEcFXu3rpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820719; c=relaxed/simple;
	bh=SiXG3Vl6tdyaZKcYbxpybRYANDdC5zL6iyKWoX1ZfWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lS3fZVa+3Mz0nSNxHXztFW2H1iSw1HLRNkN5fK9EhXbIlZ3h3FpbnxObFXVVfR3GHiKgplQ5REiNPoOMuMxYfU1zr7g5nxNmhijmDLZLKbtUzS9keRyJqYx2oGVaAtMOLWg2DE+4dB1WXLeu3aIMOgT/1zNsH0YUJrB3qn8QeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5aRUcCR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5aRUcCR"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e50979c71so207917085a.3
        for <linux-security-module@vger.kernel.org>; Sat, 11 Jul 2026 18:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783820717; x=1784425517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uW6fI+83ucGhBzlzhMQZhfNKo2rTn+HYkdwfVzxP5Vg=;
        b=X5aRUcCRnLVnkImg0aEXL20czK6e+vtn6l9f57H0Gun8KWUxU68QOZeEpIWkMLPwcf
         vbgpHXFBsjumJZaQ3tCaQDSHB1NIAYl6vLaXhPt1GCTVHJdNO7wsx7ip5qubZ5U8i3F4
         hEylView1ohjgn3l8TKfTdZPtUpUWdpzdyosJ93W83v41p/P1zel6gdkVW46HB43u00j
         Z0Ycq1c1yR/Zfb7SEWQppSbF3jPRT369zNjTHVrbhUOhW4vyVxM6vbJ8ZRjSQ2Cdl1xV
         fm6jMG3RMgg7tQwvWOVoaBVVYxSfIEqAx5j+rntIxg+2E2t8tCHUygWm+wJuBHNqW0iH
         OVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783820717; x=1784425517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uW6fI+83ucGhBzlzhMQZhfNKo2rTn+HYkdwfVzxP5Vg=;
        b=rVDSdL4UFyeDrDgwugMS+g9piwIhVVzt6+tjER796IMcahUHjTgRrCWhquWNPCIfGZ
         iUIn34U+DxR1ufM3rwNXus35/bX4v+btGCflxyCfE3AH9dJk85e/btDAhJgpIF4WmeWJ
         Atlc7I2vZ1AQb8ACUvoL6LXvac3ggppH6IhbgopmV6EoDhCcbypei/J1Ae8Kayz4ei/d
         4SHkoQ0QIY76bUNZBawwoCNjbQ5yLw+O9Mnp2KNgb8l6hNKaW7PvdrLIS61YmJRQA0My
         fXuTw53efMPXUCyWrFO6ZS08yB90e/QIGq5EfScxo+IlhLsAKNE3842gM4yascUZ1NFC
         Q8Nw==
X-Forwarded-Encrypted: i=1; AHgh+RqXxZxvrBHp3hbFyMpijdcvkRJXROjRFaLjsgBl4hWs24y07CIbh0IAsfGgyKqoJ+JFsgUP0qfnD946ObbIuUuPo1ffpHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbR7L1Ep8IrgYnr9GkcR7QLav61yGF+kje7bOnL3fk3qEUC243
	TvBpacqzzl2M4a/X4MPvQ26UJz0YmNcyb+Y7poSvWZ5ApWiVWN2fg9L2
X-Gm-Gg: AfdE7ckZpn3HJJSFeSEynuLKsRV5nPAVzYC1PkjoJcJUsm9Lg3Am4RmjyRr6s8dktim
	prdLqSL/8oY/F6zfZkcCei3jWIlAyD3Obd52R31qxr/DmpFp5ObonFBeRRkmJokQG2aNAnBuSLF
	FsMQ6FKzCFEM6xieScGy1VVrMIaq7GjqiQ9qzt7ymkoeRd/2frJ7yzjLTDGcyhRSUF+fI2+xDTy
	iDXK697pJCxWYjCNsxVzwzimYusiRj+ledYEWisHXmyL3ZXpan+k43FBiI2s4sTdreUkblg9DPz
	MODXROAdiCdlkaDDkvGUPXTRMtn5OTM4ET7WOPEZ1u7JyXZdcY/8i9iJygnbUms+A5W3cDA0stD
	V+SbsEZvJYUsCNTCYP1MDpckV8N+1vNluq/I9AT7uu9CqvQz4p+6Vv35xTRcG2/kNYAjYpQ4hEl
	G2nXBUylKK9Ri9luEbYbeH1Sr5LhreIGrZdHKKXpB7AEgHiGVHJhFkZQ1C6NqyboWcQfjMlGjFs
	nDAgyYb5Q==
X-Received: by 2002:a05:620a:2a07:b0:92e:70a4:2c5b with SMTP id af79cd13be357-92ef2d00d41mr475600985a.69.1783820717092;
        Sat, 11 Jul 2026 18:45:17 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm624902185a.9.2026.07.11.18.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 18:45:16 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] keys: fix keyring assoc-array out-of-bounds read and index inconsistency
Date: Sat, 11 Jul 2026 21:44:57 -0400
Message-ID: <20260712014500.480410-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

keyring_get_key_chunk() advances the description read pointer by
level * sizeof(long) past the inline prefix but only bounds-checks the
prefix, so once the associative-array walk reaches a description-level
chunk it reads past the kmemdup(desc, desc_len + 1) description
allocation.  Reaching that depth needs two keys that collide through the
hash, x, type and domain_tag chunks, which an unprivileged add_key(2)
can arrange with a crafted pair of same-type keys.

An unprivileged user can thus read up to sizeof(long) bytes past a
keyring key's description; on kernels built without init-on-alloc the
same collision, read back with KEYCTL_READ, returns uninitialized kernel
slab.

Patch 1 is the memory-safety fix and stands alone.  Patches 2 and 3 fix
two index-key consistency bugs that let the crafted keys collide into a
single malformed node in the first place, which is what enables the
KEYCTL_READ disclosure.

The KASAN reproduction is on patch 1. Trigger is available off-list.

Michael Bommarito (3):
  keys: fix out-of-bounds read in keyring_get_key_chunk()
  keys: make keyring key-chunk byte order agree with
    keyring_diff_objects()
  assoc_array: trim the final shortcut word when skip_to_level is
    chunk-aligned

 lib/assoc_array.c       |  2 +-
 security/keys/keyring.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)


base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
--
2.53.0

