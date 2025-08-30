Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6523BD01
	for <linux-security-module@vger.kernel.org>; Sat, 30 Aug 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563329; cv=none; b=ocbQ+1H5SO6X9i70ocTwN3XwQ/1JMOlTrqVHvxRE7STsIBbzyOSn1orCA7xT2K6Te5Z+e74Il+NOH+7knDwz8YZV8JEbXgsoWM4ZELqhQQMLXbqW1Og50QHifFpi+Bdlt6gKwhrl1chOpvIxJz3Mn7/s9Y0TpWll/KucvvdTpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563329; c=relaxed/simple;
	bh=lL9TZZ/BH9fXb2IasJ4LrIBwJ6L6IbyqBrTMpkJsTsw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hQoNDr56Lou+rndXpdB/EamgW3kmFUgg92TiKlmIESl8SOxTS4+NsREILE0wuD4MxiZn58+YKsjefG5dzbD8uj9W3bVAw+CoMrYcsIbVVu2OUiQqc7aGvsg7w7xNFR4ctXChG4KyNjgCHjQxGAkgjAIUWfC6H6XqM8e9d/YloU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CJ2NKvoz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CJ2NKvoz"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771ed4a8124so3068468b3a.2
        for <linux-security-module@vger.kernel.org>; Sat, 30 Aug 2025 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563327; x=1757168127; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y69h1UcOXut0Ylir+EUHpoR9nI3kmLoFEjeqKBYKfI0=;
        b=CJ2NKvozbnQRJikyMKUXtoTkcYjVS71c5lotg9+KiUwjqlXMeNsPUhDlyFHHqop+wv
         xZHMPuYxXYsuNw+GFZ8wpxj3ABBgYq0QSE0XSgcWxZlqK3Kw3ziDbzEYNLylxgpiTTl3
         3KpTDRIagFQPTLzfnOgZoPmclC0F9sqCt6q/9zILW+mlyAltckaec7A6ETwWBo5W6G14
         /7WNZblcENNYufhjgonfpWyUA+Xn9NIXBYdcvDav+gV6L9Lg5mkskUJSqw6Zr1XkpVPt
         3XcmcUd0n5G/T/VBkzdwlFcdZ2BZp3Oejor1NvirSXIwJi10ZJXNOHLgm2kBQvDQC+4z
         7NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563327; x=1757168127;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y69h1UcOXut0Ylir+EUHpoR9nI3kmLoFEjeqKBYKfI0=;
        b=KgWar2SPpX5C5MEJ6SewSRqhuYVimmTKkHUDqJz+iRPWx83qrFZ2Wyz7AMYuFF5nXQ
         euaYH69yZ5wVUY3iXi78tFCW8cjXBG0QTN8JumC9X/A0huDyNal6dG4G8cokNPbDN2vP
         9XrUTt+b8AxCWCpc9fvCX4+0kdrCyTG5ocY6AF6uzmLBdwPF7hSfejzVVOrMeCCDMt0n
         gxKiorkjkYDKk1sxWNQnanvfH+LAiF1Zb9c0tRopq+yMmU2lBW2ROLKnP+edkD/FZlLV
         xbjofIXBwMng4xxH4AGEhIWID0Hr9nxxWzATzhvEfr5l+IIhws274jn+BG/vh6HmDk5M
         IL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+8osFB/HHFirAYW2uoC+nXdWNhlPxKawKoodqzxl/OENKe7UrGG+oT5K4YCOlYQWD9HztQ3vD1JB2O1I93VNF8KpSmNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMIHsHNLe725WxUuPqv04un41v6nJBkeYD2MA+7dspWOgdtWV
	8mCgaH35nLFc2h/3N3fKziQ/iiTvNzr3dvABdg9cLXxT4HQVs2+RjUtqXp2Uf+bWTA==
X-Gm-Gg: ASbGncvavLBjQUQjei6M8ZKZL1PXwRvpXL72mdreApdiYKqAMVElJuBIqRUlLpHXryI
	Ne0yjGO5C5JFSTb8xAPNlXhGIEZd+9Ecw+pV1xg5aLTlfDlyX4C0bXqB+PLYTXamVJaTrw9HFqj
	p/5cEy3wIGHVWXtqQmO1plQYO4uXML30M784BiM6nvyGpd4MaOtP9VV31Eeun8qoB3DmiDVMI3U
	ZpdX5rpL0KANbDd7HDjTQugpui3ujkhZVoPZuLKyl16LxTOpBy4+sHOIolK0k3Cc5NOhdIJddzK
	JP79XLFEg6LyKcrOoeEj32qHV3wug+zDBIo6asn0cTETJ3BvP9Z1iq47DC/2+JMQL6l6PdYRSYD
	GQxQ0HzJo+68StDv6DtJ+jJQB
X-Google-Smtp-Source: AGHT+IGL4OfyFEaEZdVSYEKPN6ZBrAyplAqXNRfv6Ik+ZXab4VyJSnykpSuF8eLpW38m9zQkwRaHpg==
X-Received: by 2002:aa7:8881:0:b0:771:e451:4edf with SMTP id d2e1a72fcca58-7723e0d46cdmr2221100b3a.0.1756563326726;
        Sat, 30 Aug 2025 07:15:26 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a26a0b3sm5441563b3a.10.2025.08.30.07.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:26 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:15:17 -0400
Message-ID: <82fda5ee57f82d4a470d08969781b6c0@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 4/4] Audit: Add record for multiple object contexts
References: <20250816172859.6437-5-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-5-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS record is:
> 
>     type=MAC_OBJ_CONTEXTS
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  7 +++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 58 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 38 +++++--------------------
>  security/selinux/hooks.c   |  4 ++-
>  security/smack/smack_lsm.c |  4 ++-
>  6 files changed, 78 insertions(+), 34 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
