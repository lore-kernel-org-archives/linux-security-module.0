Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D963C3C1C
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896003; cv=pass; b=hlkXYsAUqNwIiIYnXBzWVIyoF3W4Xb92hPIAwP5lnODMm7hzv02lKQ6qFrDCKCQB/ifoZmTPpaTyRILfE+VLGyuVraGT6FUtdce0jebe4MVlU66lMq8tUxQCQlsEETyN10wo/sVlI5YhsOw72ruaUF387TEUgMPUbPLCmLCTtiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896003; c=relaxed/simple;
	bh=H3DOZuT5U71ZhBZfKYvn6XDnq1zdutTIKDZSo/ZnoCw=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=nZtb2Aj0oSMZCNb49wl0JnYlcAYcZ4sQ6hnOYJAGOmZ82vb84TK0KC9tab+mvT+prVrh6kToDjkRauwe1mDIzNxcvg0+SSw/1kfeuhUjTTO4roLF6AmhyaBuwhMDj71VyaRpTXIHtrx+zFM0cl0vKV1c3O9Mr9zG9cYvNCxxtd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=L/r949cD; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="L/r949cD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccf2360620so6096645ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2026 22:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896002; cv=none;
        d=google.com; s=arc-20260327;
        b=EmCYnKE+toMbHwHjOQwXicNSFj6SdrW48qSupfFH/k3Z0nlISexW7Z8g8wzGLmRLSe
         Muq4KBkpUuIjfc2q3aIVjRX4DsdSCCNu2MBZfgImAKpoVCWfl+22K4uk9YkE1+RGUjMb
         pf1HHkcAhQPGM1zhenKxQG7ie/xEXKNWp+TqH80A0uFwhh73XMOxFVP8q5w73bj9c312
         UvKpAIKZvUqycKW1cBAkcfBhWsIdSQ7TgWb9htVSdGNxESRc2iHDBjvMBxdzUy6uNLFs
         KNwF1JlYVAF+o4eogqe1Xw1iaFtDgPxspVJ/z4HKzyYgsPaFgLV43/WwjI+S6GPmqBMa
         baBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=fPiJId3tOuYlDXjHCXBtb11mj/amv2bXs311mP0GvCI=;
        fh=THdxrXnW9Prbb6R8D838E2LwkbIcQBK9T5FPfgiPC7g=;
        b=De2fOuJsAwpKWAMwwSkyQMzmu8ndkEROuSQWyJBVqaVgiE7xBbhVFD+YmSP1Y14P1g
         AHeigk88RBHJFWFIa7VG6EtODIEcHR1q/4NhogtihBSnQPbeWo8z6apBo/VOJub5boZQ
         nwnn1xsDBxsddRJluLE7j9JGTyVgHIHQhU/rzhL3aeM+D+meGzXbx1a/gxu9rickPiIZ
         1rY7umD6WYavmD89yWT23M2kYJg00/ABqvTuIwnBp5UIYzJfZQyOHSisjhiOZPUljKZh
         r7qbHN1N7MUqJ3VbQou1uNrBaHBh9KR2Y2b01yqeY6Rc4I0rEOtmEhIvLOnwoIJb+ALy
         pgNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896002; x=1788500802; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fPiJId3tOuYlDXjHCXBtb11mj/amv2bXs311mP0GvCI=;
        b=L/r949cDpj2Fgb8YrJGP5GhTGZm+FlGc5Sa/BCzAmQ5M1+H4BGqI/DEh6Mym96tIif
         AHLfvC4mdu/Tsq9D1VyM8RIwtms0zLE0IAoc4yJVNFiGDDxrWHVU7Ayf62yl67fPtwRF
         x3wtpRo4Y9bBLmAQP/tYIh8LB19ieu/bsBT+y3fNsRy2BVPtHsjRwllFXx8+s6or+kMG
         TmuU16Gw8Q8EBhACTzFTI5GG/p64EGPmLHPaROw6rUKA2uDvDUpLUSC6iUqqkNybB0Xa
         P+pyljHPo+jkIAK+5tm9cVzaLYrlPsMhIDrZlhf8RYxJurMlBNfRzlCD0grabaT9azLB
         BlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896002; x=1788500802;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fPiJId3tOuYlDXjHCXBtb11mj/amv2bXs311mP0GvCI=;
        b=Bm/xJlg2qFBoV1L6ixBZUENELat+KuwMz9z6ujScKLSreo58fkzF9y+fWkyckPJDBm
         qawdPyoGmdhObH3g53lsg2Ioo/dhFtE0m9kI4vjJPkRfpMiqT6LJYIwvik6mWYvTN1gt
         AK1KusOUfyrl6bCBX7xkQjh4swYUuObHyoLWEoR5cbdHNpt9a841yQpK61+zWSa0ZSZN
         WmRqS3d40gxRzwKuRK4xZJ9QWTbzMhV7ky4r90bNvWOc9uLK7MlIyjhkjQWMCMgul6FU
         laOPwJ4bUu0tsHcyw+RfPDzTrgDiMAqq1oOhzzHKRXTOG3naaZwzsMRXElbV5d0FY+3s
         Ajrg==
X-Forwarded-Encrypted: i=1; AHgh+RrBSp1/ZOotV9WhU2sEDm9dISIRc0v7kISBVh4S6OuJkd4jBVYCLyjmkFdln69rTidVnhx9ploLks9v4vo7MfnMfIJbf5s=@vger.kernel.org
X-Gm-Message-State: AFuF++l4AcV3kVYJR+l2l6/WBWkxKqN6xrGCRPWMbIOtVFnjm6cCuOcD
	hCUXV1Ob0BRcZ6EjE5xUtqoR2wEcDLsiYnXmWQ0YJZdUWJhRIjBybt8fefH5Y67rW+b9xHIeMZ+
	MO6fkVL1mwDy43+eOBAYuLNPbKbUy3IBr1pKNp4KJ
X-Gm-Gg: AR+sD10MlogJ+NVrm0rVIJPrQnGDWwl4uTuCkFmY7w6jiLS044UvQkXWVzJr1xNGD5A
	iaamnoNnW+8lPhDDFWZS8IRCuLavij1NObO0hAIvfUmg5Rwph6eWyy3nnV/LfkFwQgCFgumwz6D
	1lVLcYogxPMscEE+kKcQNpQsrPrxEmXrkxOwqItNKl6E8xbYo/ioagnSdET28V6+OosFuINK8Yw
	pvX2oTtIyfJS+MqFov4ILObgLyevv0rV51KXPGsgG5NRUzVZevl5RIAX6QsE0TCWNBsAn6pjwzf
	+0UhFcJ+IODwu72RMex2I9D8p/qyMTUztXWq67PvOaVpKiXHJ3KULDFsM6ds8IvCaOs0NEEE1i4
	KKuZjyEy5iEUifY6gh12ucFP9S4NSs2od4sy12qMw20s=
X-Received: by 2002:a17:902:d551:b0:2c0:b6c7:227e with SMTP id
 d9443c01a7336-2d74dc2ff16mr88551055ad.5.1787896000885; Thu, 27 Aug 2026
 22:46:40 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:46:40 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:46:40 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:46:40 +0000
X-Gm-Features: AcwNN1WFGptDLW8DFsqByQqJY8BAvYffBJ535kZN3uhDUmZH5Ko6eMgDUF934bQ
Message-ID: <CA+0ovChn8nTkgAs3sw+_YDhKWszxMj-tssbPdwGjPMMC7zEpyw@mail.gmail.com>
Subject: [BUG] general protection fault in security_path_post_mknod
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: falemi@asu.edu, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/178-general-protection-fault-in-security-path-post-mknod/

  Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:security_path_post_mknod+0x49/0x1e0 security/security.c:1430
  Call Trace:
   security_path_post_mknod+0x49/0x1e0 security/security.c:1430
   filename_mknodat+0x40e/0x660 fs/namei.c:5172
   __do_sys_mknod fs/namei.c:5207 [inline]
   __se_sys_mknod+0x3a/0x150 fs/namei.c:5204
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x146/0x480 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
