Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC03FBE9
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264829; cv=none; b=aU6GVvVCyKvRfai69wD5Amb5onva18BiLLaCP5d9/Idq50ywrrXpZJMEObrMzKuGzx8z4F/ci65LFvHDaKXiy4AjlQA+xG0muuUHgqjH1kGXIDAUVyf2cr6juG4xaI/gSbyuufd24HW04KlLi4Ms/q/bcHOGwfYVEIbpSzSv5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264829; c=relaxed/simple;
	bh=E3CNNYto1V7JNBrmrNOdsJKrixGKninqpVIj/qNxZlU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oeUGFMfTH1qe5Oc+I4sAxTfQ1u+IzuBMbmDbtSDltl8EpuiBq5UBZDuvdLq+N9mraYgJRGIkEcEy495eHPEsZTkg2JDtiph7uT5MD0mpwgLG2oDExU5cZk/cciSEr9tEkKniEG7lYC3Bkv+yt26I+3Q/yVvvHBd8PUV8fWsWF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AK7dAWfi; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AK7dAWfi"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d8f31930so85420276.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Feb 2024 16:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707264826; x=1707869626; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9R6mJtFtSzpohL/zDF/Cz3F5YRk+F7YeJD2F9QeCyWI=;
        b=AK7dAWfiXEkKh34GBZZ5B99VZjBX1qeOrYKM+PgrL4GbzMXgNvPkS9mEaVm4tbaetT
         mOKN8KiXXWvi39e7C1LjvthiMbR7nylwwPCtirN7I6LjNrjp0a8x3Ww4xMwjRMfhL4AX
         ViKQFqB44wgHCmN9pqmNdxi81v+eaMlVJ1tIbdkOA8rgzLf7c4LVqER8cj5Xpd3TkTYA
         s0t6zAskoQIllCXYPhck7o/U/urGVHkjILnugRcxY5l1V7f3XY5yCrIhq8+oStGVmZFp
         9wT1vH38XpO6FgxKPOL9WQTygabbWecK2gOp59SEzkIhVzUhChRyAmHMKbw38VT0ZBPJ
         4kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707264826; x=1707869626;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9R6mJtFtSzpohL/zDF/Cz3F5YRk+F7YeJD2F9QeCyWI=;
        b=CyTnCLHdrUPwA+tATatl9YR5GL2xJ7ZRLv2+jTOYKVuxoseuMly+fdLCSjQ8m4SqLR
         Gf0jLNveVeaUKjIps5CZRAXLu8X4WN/B8RnPytmTotB1IzfLo7A7pNt0AmugyLRckN1x
         dGpD9G90kh0fyJIFnpDDM59Gapdcz9c1+K4pMC93nu4aBWwkmh/pEXs4tWP+TS+PwAmL
         PrEscRCUtaeuYqv6EKLyagIa8q2Eua6z83nyub/E5xNOXm7yCciRMiMJuxdpIW8wEop1
         eU1GbZ4Fzt0nin4v3H+7Iw3caA2a7MpoIwvXSel2EkCGpexHnHoTpuv5r5n/3RF4oCMz
         w1/A==
X-Gm-Message-State: AOJu0YyHdJ3XlThYqcoo6c1cRw2YwFFysJfSwENUQwq+lCISBkLBpkA6
	jBsS6bx7ZGYUJ9cB1E5d8tx6OBXbMPInbZnSUYEI9itIaMqK5E6835bdEalhtMjY8yoltW48jXz
	CRURPkFZVAFi0OHGpVIdn9zm5FkWTQH+rBKmfP6Anr00+r/I=
X-Google-Smtp-Source: AGHT+IFigTzofDtgkqWeKa7sdh/muurosYFup6EpdsiZQVGGdRsGdjwVOxMITFHmVgAdPjQtbXbaOo+xR8/WDoHupbQ=
X-Received: by 2002:a05:6902:1b02:b0:dc6:d1a9:d858 with SMTP id
 eh2-20020a0569021b0200b00dc6d1a9d858mr2989522ybb.8.1707264826163; Tue, 06 Feb
 2024 16:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Feb 2024 19:13:35 -0500
Message-ID: <CAHC9VhRKj5K144Frke0o3R+yLkuz7uCfT6UhOn7eoB1gxxa6jA@mail.gmail.com>
Subject: ANN: moving lsm/dev to v6.8-rc3
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A quick announcement to let everyone know that with no commits
currently in the lsm/dev branch, and LSM relevant changes in Linus'
tree post v6.8-rc1 that I suspect we may want during this development
cycle, I've gone ahead and moved the lsm/dev branch forward to
v6.8-rc3.

For those of you who have already submitted patches to the mailing
list, don't worry about the update, I'll take care of any merge
conflicts that may arise due to this update.

-- 
paul-moore.com
