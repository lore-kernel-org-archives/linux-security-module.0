Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E33C9453
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835178; cv=pass; b=kgaQMJQcC1zoNh81etEKxUsex3wLlh8XMeKX8mgkTxIbQ3zHqRDjFfSU1hNuUwmwi5DfbeAa4wGeahkd1Zl3307YUt1hP6iGsrwI0U7X3Mrq1P1Zcavb1SkAta4vNMTEvML1SPhjk7xeS3Bd8UtcVsB6E1gjW4VilKwgajNENj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835178; c=relaxed/simple;
	bh=GwwBrn+z9SObIvq5sU5oIBL+gVqrYcmXfApHax8UX/4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QmuAF176+kJaaCNFcK/xzFMreBHJ2gQKzsAo5x+VY4y+Vt9RWGDAJDo+jAP4PLJJpDUaNLpoBsLE6LQFHCTQ+VBSWsfbmduJ58OclUU7UJ9AlWDmTpnLOeXXUmFMx9nheh2rx3Ep2uHBR51Wz5ITgApY2u7RvsolN3hFW7JpJxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lceRcue8; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lceRcue8"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so10656436d50.2
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 15:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779835176; cv=none;
        d=google.com; s=arc-20240605;
        b=Gvw2aDYCCw1xw9nzf5uwRINyoJJbySjBl3qUd0SOOtd+q0oBCgqY6v8nYtznGdd1Ih
         8dYKNoJUcqOvsmG/+dGnD5cPtZN4QhoXEiXHNvLJkQJ35tqfymsf9ePZDtOfU+Fw14SE
         r29f/1XURT4tQcFqbeM3jlCLftp6Kxc1uhAynQFRD1mLmeqdm28uO+H/Z/py+LaMeVw+
         s5iCjIkaop3zlFIau5whHCSUOEYn9+WDbreaEsyOoOJGlh4suxeOdFN8w0FpaUvBZqMR
         YwrEugma2DzFEcM4QABHB5ENB5ukRc2aZK63IEbbEdupAGhC9Cjel/X0JLgq5ljW9JeJ
         5cKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vVAt65K+G8V38AN8GApoYXmDVFMGK2WPPS8C5x4E7bg=;
        fh=Ddg/mOQzvbxfJZhF0+o/0WnRP0S89C36YXFk1Cxrflc=;
        b=GR4DnXf0ROaG1NPOU5b+wSxIt+Ssc2VxdTYQ/3eOBd4+Bp9N8seRGEND75SMCVo4Yy
         2U5MrxacHlW+P6VTapXOuM+KLWy4WRR3KVB0jDHJkdX7CxgeWwtoO6PuJNDTpchprS0m
         VWaznilK5xI/LJLVetkBp9qfSvBpxBuGWSw8Du+wCAd0amyZ0Co6Fy3WjeFsjmxjebQv
         WKKHtg26IQrxGjtdwcv4TBE+PYTOo0XJd6FxTn7PAOB2TkqchXSI6hbxvEJ7+/nf9J0X
         zc3MCPvXO/036Zm8ZpCxdCgV8LD+diEzJaUmePgBOCmCkw1u++9NdCCfyh5fi+slcovl
         6xHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779835176; x=1780439976; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVAt65K+G8V38AN8GApoYXmDVFMGK2WPPS8C5x4E7bg=;
        b=lceRcue8aRHW73NI8nB0p3vfOSQGvA23w89Q+9Z9nocCoyu8fz3HnoHwCsTmx0Zpc3
         QqX0+mOjlI7wCxEioHAArNaCwVT0kt21P1ZNOp/pRDcEGA4BEJp4PXk/vme9xAH9mvm0
         7lquAODrLG8jTyqAdV5h/eAiEAXD7wvfF/qKHpsFWtcwy4Od/uq3+j/mJarBt3skvUS4
         7s2Q4vIrmepBu4PBYEon+GxURBBt4wP8rASJUQJ3fyb2QWML24vnbeDON7sGh75RW9yI
         76Yzrd3jpu5FiG483MUoUaSXzTAXhGHpedvQaI71mXrHOlUFRu+A+iLDN6sAMS7NvNz8
         KrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779835176; x=1780439976;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVAt65K+G8V38AN8GApoYXmDVFMGK2WPPS8C5x4E7bg=;
        b=EAMhZ/5u9I9Q1+nI7OqnV10wwKVusLE2YS1b8Yc4S3nU9Pywk4L8/LWWMb1bPj5v9j
         pwFleEMDZR3NXftkStWLuXOQRaniHKJ6tIHVpxAfCaUut6XgEhjqE8DxTUJCFUinc7wm
         67oTxq2C6CPIOldateJUTNzDeEv//j00ywO+NoORbxgPZTG9ZKIF2023V8ncKSawWShl
         x1Dh/+QfAcW63phBBTaKcY0yq4tZyjwIwvpcrkqYVS2hBma43LKvXaxLjwJzsc0nWrqs
         NwyxqaUcSM4+fKKe5zkRDvExaE9cKS+DF1fABowgWFtYQqdzVE+Q3cRxK2/0UqJ7SelH
         X4Wg==
X-Gm-Message-State: AOJu0YxUAZYj6t3mw0lGWTbYcx0rHdq7G3Q3uGYHkZ06Vmxj+XXoQCuf
	19uP4TPGPMEIaGIyHILYPsPDBHLY8Ix0gyOJQwDopl4PUXkwsFC0UStRYjuSsGS+yUgMx6OYN8W
	PtQFSae6VwnSqdtQyHs0C3FIE8UA1jEC6xD208Xo=
X-Gm-Gg: Acq92OGpL3dOUt9pTYrWqXHJoNn5LANRhsWrY56GAmeDmW7hLAnghucIkeXh4UfUAay
	UdFD6TQ554fxF/HmcmFh+4X8V+OhbihUC45iZoPnjFyc0mgA5kxCPFBeHXyTpsa89ZwgnhvqPok
	YFz5aIpuwNCtCzOVwDwe2NncCBQGE4W1J0cUXynsgLCzlwWxXmsFhMB4ORO8SCdBoSpWEuDh7Q5
	VtqC+5iDRZafONau9yXuRU9F/Jzpkd+UHNWyZh5GonfhqYPXsZpl4ud6rsilGswvETUvqtHnsDz
	LCeOPct8POhzzdXzWfe9kXWpUkDE
X-Received: by 2002:a53:d057:0:10b0:653:1c2a:94a5 with SMTP id
 956f58d0204a3-65ec96184cemr16436623d50.8.1779835176242; Tue, 26 May 2026
 15:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 26 May 2026 17:39:25 -0500
X-Gm-Features: AVHnY4LBTBZu9I3pGIJPzVCjSbKmaYPGo3IVDyncqbmQDO-59BE8QXKQiGnEh9g
Message-ID: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
Subject: security_task_prctl: why -ENOSYS
To: LSM <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I am trying to understand the motivation behind having
security_task_prctl only continue if the return value is -ENOSYS. This
seems to be very different from other LSM hooks I have investigated.
For example, in other hooks, the value from SE Linux avc_has_perms is
used directly. This essentially means that a 0 will cause the check to
pass, and anything < 0 usually an error.

In commit:
----
commit d84f4f992cbd76e8f39c488cf0c5d123843923b1 ("CRED: Inaugurate COW
credentials")

(8) security_task_prctl() and cap_task_prctl().

         security_task_prctl() has been modified to return -ENOSYS if it doesn't
         want to handle a function, or otherwise return the return
value directly
         rather than through an argument.

         Additionally, cap_task_prctl() now prepares a new set of
credentials, even
         if it doesn't end up using it.
----

The check in kernel/sys.c is currently:
        error = security_task_prctl(option, arg2, arg3, arg4, arg5);
        if (error != -ENOSYS)
                return error;

Should this be something like, "error && error != -ENOSYS"?

I ask because I am looking to leverage this hook in SE Linux, and it's
annoying to have to coerce all 0 returns to -ENOSYS.

Thanks,
Bill
