Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618C13790B
	for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753744690; cv=none; b=BoJdsk+YgQ9wpu0NC4XAhJab/MKmD48R5KHTGwFivw9iwRMArrWZzSAc8bINPtZprH5Gc7XydEi1VIlxuoDRn3ep+Q7cnVYjYPcAmki1VOPpQKd+9Z4yLm4qGzJE6R0NbYXe7tbxlXMbh95UGu03DIUPm/4WQV6dfOIl452S5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753744690; c=relaxed/simple;
	bh=+5v4EyzfYz+gzkIr3gBQl6s9HTKM95D/6OF27MCMxPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjoAoDYYDs782WD3fu1sJn/jnNwRcp81CTXjMx7F3RVfp9dAQL+TcuHA2GdTA+kCWF6C3X0Jdua3w4h+2YPxHb9SbBNqz9C36MQL1W2a2kN3inr8JfUf9uOMZjZfvOvN5NL68HdF03lEgh3zyJ3GlSuGynRCWxgf9WufqdiAlJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D+Hbqn40; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D+Hbqn40"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8e272bc03aso107672276.2
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 16:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753744688; x=1754349488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5v4EyzfYz+gzkIr3gBQl6s9HTKM95D/6OF27MCMxPU=;
        b=D+Hbqn40JK/4LxW6BAfhz9Ac3o7ytbTZuDREeVbqMlCyuv3ZIGdaF1GtvGBKV2R5Et
         OArNQM33cE41QDfRfQdTeSSCxZbmoC1F6bJJyUQ8jVDhKR7eQwgEU8wWpz5+e5RSjCSn
         vf8i4XzQy8tHhwK1Kgwzb+LCxclHDRoyrAvqwSMhtbkYLlClaTIqssJgF3qFAYmAd1Wc
         QSTima4jeG/8UDJsXx6BYBWnORghX4Wf9X1BqV92cDmAi/oFICzMjkqMzbpo1nHCjfCZ
         Rg8B9AHN63oxZimAGP3X0TSaQz19T7X2M3VwkP680stpwZPVZ1pEYmTmZrIJKh/Z30OD
         LAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753744688; x=1754349488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5v4EyzfYz+gzkIr3gBQl6s9HTKM95D/6OF27MCMxPU=;
        b=COyx9xZlRXWM5DqKC6D3zmVk0+VzAgfbAZFaiXbf9l6zVDm9rsI0l5heUfhUm0BJRF
         KtdHWkHIu9m2ED401Jom5pAFGUkg0rh5H3rwXM46FPu1yWCZmNUpeV+QQs5hyK69/YbK
         sXbmkWDzOYbOxBsx0+RUw5Bd738GbSaR6omrPbcKWKn+rhlmyu6CqzD5sjGHFA/k8d3k
         9216j3tPb7aC+KG/1k4t0eqa440ymNVMMTe+qeiDzbReNC1o+2HWD6NGYVJJiE4OrdmZ
         NLNdVrkyJmUgy+e3P4xVe40QFceT4E0G6yndfbKFVb9ggS3DjywqhpeOYpxl1MwXYrRH
         2Bzg==
X-Forwarded-Encrypted: i=1; AJvYcCXjqf060OKU6QhlAYrtEX7TQ6LNvDnS9P+kEwMWAqPrfYVDVtfoM1bShYutiyXN5BawLGJvkSpvZUj+TllstV+6lzW5ez0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08EehKNRceJRhkjockuCI5qidnW1F7rAUIOTauV7rVKfWP5m/
	2QtXWmS+AG7R5ILGpm9nPBKMB4HXpUAr6M0PMu7oe2WYY5SJILwVyRlG7xuMWd5i8zLD/H+n2IO
	azVHJ3Mvk9somvH+qIeVDDyskuD+I3n+WoTknsS+TlS6Ql/HejPo=
X-Gm-Gg: ASbGncsFv0MbK7CXJfyJcT8/HwdA6rNe1iIs/Tl6mFX4M5EOjJIJOcsKJhl4LOnlXUO
	IMdfDZ5OlIE7cEr1Nvj/5OUIDEH74mQjxqrllY3OOaCSH0T7CsIbiSlM4DElHAEX+EK4VOtVJuN
	4d3gqLAHqy29dx7GlibDvuSZLxFrHhBrt6aaYXjTHuR9QHtL/zfDg4UFBgn/RSXtCqfkO8nqAUN
	lAR9hg=
X-Google-Smtp-Source: AGHT+IG/X+E3QlC3IyJwf6Emvx9Om1IcYPLv/AmMMvKdtQPjzc1u5H3yHERh2L7ELJBLPM2dPnzM42tjyPw4S6dDMOM=
X-Received: by 2002:a05:6902:2185:b0:e8e:2174:9250 with SMTP id
 3f1490d57ef6-e8e217496bamr3565505276.21.1753744687842; Mon, 28 Jul 2025
 16:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-67-paul@paul-moore.com>
 <st4eimc4lovdeqrtxfhwjpgcblyufzahec2hmtrxvkpp4woejw@iqeuzubt7afe> <6c5ebaa88d1ee15046e9ea0bc61d9a843b850200.camel@huaweicloud.com>
In-Reply-To: <6c5ebaa88d1ee15046e9ea0bc61d9a843b850200.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Jul 2025 19:17:56 -0400
X-Gm-Features: Ac12FXzEtyt8H5xs0GuvsIUN28Swa4HLP0SU-QwDPBGEEJDBopXyR-wxS1WEj6g
Message-ID: <CAHC9VhTfD6H7_6coAZQ9GzxF8ujTVNbDqK-0a7JE+iCd7E8CHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 31/34] ima,evm: move initcalls to the LSM framework
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 6:44=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2025-07-28 at 11:46 +0200, Nicolas Bouchinet wrote:
> > Hi Paul,
> >
> > With `CONFIG_INTEGRITY=3Dy` but not `CONFIG_IMA=3Dy` or `CONFIG_EVM=3Dy=
` it
> > does not compile :
>
> Hi Nicolas
>
> thanks, I was about to answer too ...

Fixed, thanks everyone.

--=20
paul-moore.com
