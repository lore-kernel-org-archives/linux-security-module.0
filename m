Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDC30BBB6
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445945; cv=none; b=aBOAVOZEHRR8EwbVA3qAkrd6ovIQWgGzVDH7UUdDwOi5sbHAkEuBqNyNCrVY4YwSYcgaJeFme6pU2Lqdjnogq/8PCiDvLean4zPbeoz2+d7nOEuJ0CmZzG0ZWIXZcQo3lEQi6jlSi++dsV0vi8LJjVYvM2pJVMD1ATh/0gRrdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445945; c=relaxed/simple;
	bh=rHfMF5ZX8S9/KqTE1mQtWowuQ8gYtFJjP20dw83Yl3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uxbfdml8sSl0AwWOybGOJgXmFq7Ul2VlSPnsyQB8zdmvruaV0AvomjsqwdTqtfFoFudSl2JlvSW/dBs0dOkPKBHHCxJywxyqtCuEO09asunn0Ua7i3qNKzjt3FVy9kM9H0anzPh/6Mcgh7MWOe21GM/cunbMVUk+g4PdFZmo9Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+PbLE9D; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+PbLE9D"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79430ef54c3so2096237b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771445943; x=1772050743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kP4ewcSh1KRic7C0OgWssvPgsKoLqF2csfuE5RSoNkU=;
        b=N+PbLE9DbBjDBE2yVrn0WfX4DDTpXIMqbrqGxWrEC2/aGAWa7jq9eWsPwMz/rm9z00
         7EEPBkh1hRejInoHTeToPh96EZZunuiuDFgVKmMmIHUzWPBZpCNL/ZEyPMaVvvOaigVa
         Pyyxg5f7Q9kDxiLL0R/Da0jbHUXV+3bCrtm4xU7hDVzk6t2CQKwBESklpsjKMoK2ANKa
         3rTxIqg0yDZmk7OotDKYDiB3fPOYYDA7d0gMciJH+QL4hnhDwpNQ7PAKKiPK+7us6Ujt
         wGSVsyqjtDqMAc2PKDdx+SkvfzYgazzpLyLAdIeKUC3oTWOmqPN9dScXFW9p5P1a5Fs4
         Egag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445943; x=1772050743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP4ewcSh1KRic7C0OgWssvPgsKoLqF2csfuE5RSoNkU=;
        b=FDxJ9S6LYa467rXJy9UwdUdeygcw7AEnZDqxVSM2P7gG5GH6vqwxbs0g72jgwYH2ox
         w3ZN89ADKFiajqQPdXIRQ+3RmG9+SEy2XrVn+np+Z/g9GFynN9Z7Oo+PMYJ1a9N8Ln3B
         cwS+SVPXexzzu5BLAisVjYsMwVlwkwflu9tHBBI/Bd09lCSHIaLBVU60aAVoGfJojFgv
         k8Z6D/L3tGlqIv+nVFg6PZiKizQe1GjWHrMkH8lZIKDhUINKyuWgm93EolVDCFuPuY2T
         +v/ZL+SsjZ/o5XKQJvzzeX9NyfeW4gjY22/Qi3hoAO6x8YTttKj8hcjR/7X8Mk2HLjeN
         6ppQ==
X-Gm-Message-State: AOJu0YzdshlLWnOhqLL2znRMdzWv8wIEv9aqB0qBJj0fOQtVp4MtdzCo
	WDV08CXMZU7wqwwv+WaJJ2T9V8nClsj+NECwDCBX4ixkWfV60mf4l6gBvhjIzA==
X-Gm-Gg: AZuq6aLOXq/WjB4gl4+d7uC3CmNWxOn+tgIeKnNRRzzQgA9aOdemLeFUoiypJRoFjQb
	EB9eyEPDcgF+8mJ812WZXoyyDWM5qlFTi6fxG4aRPEFrblmhQQLulUPF3C0SxdSbIuTJWlypkzu
	IHF+L1TzM46nCLDwPc9ckjnqhLsd74WAsjOU+vQ8RliRp3pdAn+qUP9FVyhAQ0vfohW9AuzWmHy
	jBv4wJKI81zWsG0ECSlQBf44YpWwwZDYmtx6fSWFbhAqE9fzjK2T3hxUUGmYab1dDDotTFhfuqQ
	eSkT1rfsBOHeodbW66pOV3eDwh3znkZzksL82Hi1GjmPw4Elcxu8WWw5fjvQSVEStTw8Wl3YWom
	KRZER35M/Wf3WO09WiDc2RLJwNlEFtJAZXW3YqMotzMEhQ4exS3yN4NK47xJBmIZYX6TqQj3opg
	6QCTK+UfmKXZuWJze4/Vvr7d37bQgBZ/7D2pzDpXthNjIP/sDwhNPMEbDA5ib6qLeJRiSMhkKw
X-Received: by 2002:a05:690e:4190:b0:645:5297:3e65 with SMTP id 956f58d0204a3-64c21a4389cmr12472334d50.11.1771445943353;
        Wed, 18 Feb 2026 12:19:03 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e936a7sm6249560d50.6.2026.02.18.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:19:02 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 0/2] landlock: Simplify path walk logic
Date: Wed, 18 Feb 2026 15:18:55 -0500
Message-ID: <20260218201857.1194667-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

These two patches simplify the path walk logic in fs.c.

This patch was originally included in a very basic form in my
LANDLOCK_ADD_RULE_NO_INHERIT series [1], but I think that it would be better
submitted separately, as logically it doesn't have much to do with the
feature implemented in the patch.

This patch is based on the mic/next branch.

Motivation
===

Additionally, existing path walk logic is tightly bound to the
is_access_to_paths_allowed and collect_domain_accesses, and is difficult to
read and understand.

Centralizing the path logic would more easily allow other Landlock features
that may rely on path walking, such as the proposed path walk controls, or
my LANDLOCK_ADD_RULE_NO_INHERIT patch, to reuse the same logic as
currently implemented.

Background
===

The first patch in this small series introduces a helper function
landlock_walk_path_up, which takes a pointer to a struct path, and walks it 
up through the VFS. The function returns an enum landlock_walk_result which
encodes whether the current path position is an internal mountpoint, the real
root, or neither.

The is_access_to_paths_allowed function is then altered to use this new helper,
cleaning up the traversal logic while retaining existing documentation comments
and improving readability.

The next patch in the series removes the collect_domain_accesses function. After
an initial re-implementation with the helper it was found that collect_domain_accesses
could be more succicently inlined into current_check_refer_path and there was little
benefit to keeping check_domain_accesses as a standalone function.

These changes overall reduce about 25 lines of code, including new documentation
for the return values of the landlock_walk_path_up function.

Results
===
These patches pass all existing selftests and kunit tests, and favorably influence
stack size.

Checkstack Results (CONFIG_AUDIT enabled)
===

Current Master Branch:
0xffffffff817d3f40 current_check_refer_path [vmlinux]:	608
0xffffffff817d2f80 is_access_to_paths_allowed [vmlinux]:352

This Patch Series:
0xffffffff817d3db0 current_check_refer_path [vmlinux]:	384
0xffffffff817d30c0 is_access_to_paths_allowed [vmlinux]:336

Thank you for your time.

Kind Regards,
Justin Suess

[1]: https://lore.kernel.org/linux-security-module/20251221194301.247484-2-utilityemal77@gmail.com/

Justin Suess (2):
  landlock: Add path walk helper
  landlock: Remove collect_domain_accesses

 security/landlock/fs.c | 220 ++++++++++++++++++-----------------------
 1 file changed, 98 insertions(+), 122 deletions(-)

-- 
2.51.0

