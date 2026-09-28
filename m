Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2526367F26
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610364; cv=pass; b=TvyQjcrrUgnhROGSGocqP+7Kc/o1QYYGzaK8eXKuuLB0tvTJDfyCEbLaI9MSBV0b62F6lmenhOuANw2UBtNqAb+LK/k+1QUpwl/8+5ubN9k9jxIJhzCvMZOoaxHnLTLRQfr2tRMjK8m1G3yn5iHTW4LOQvDDGhNKVh258LETFhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610364; c=relaxed/simple;
	bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udpXG0daI/3GjOckdtKAeZCl+kSWNECqEf7ZXTCgmD0ZSkAN7H7MQgbghun5O9JE7EUrUfz1VdZ+OnKO+DC6jQJb48SO3gWmMu3u+woYlc79Os3cPcQfcSE66rCNlnzscARf7zR3ISYQGqnp+B0KxO0XKsA2/SO0Zp7fBxpr424=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PZkE7mns; arc=pass smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PZkE7mns"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df9754484aso15049995ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 08:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610362; cv=none;
        d=google.com; s=arc-20260327;
        b=r0g9iZfefmj0+fh7/045mA8mPwSO9I1sQQkS8e0ziZfVYalG/FM86khdvA0+yEmxaa
         faz+98Ear/lqYSTrFng5Q5Vl60o61Bqb2KBrs2m5a/it4yHUq7nAZmenHeNjZ7RhV+e3
         TpyY9OuKu1By8K3QcvJ2QhNWnbhKQzCrLGmKufscXsQcjUd8UML+ytgpJ1GLZeqG/UFM
         /ODg3mn/SKEzNXQ9QdrjEU99kH3msUYKjK3CBFacNFPlDr1HNJ2PX3hGeMZ8mrEcrCmI
         mOf+wmZVqzMXsef/snfGNHOMlV0MkmpeSgfmSf2mGYOrqf5tn5vGxOJL3tuDtZ4mkjre
         riQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        fh=HeYkLotJC8s51Me8Pjsr0mY/9Kz1qQT+8n3+3qqRKeY=;
        b=gTH53VD7WO06K+snAiXRCM0DBtKGymoLTG5TbybPmYhgj8oo6tVZ78paEb0ktvYN3R
         daMXvCqhPfuR4ifUAtD+X8vGeTA5oakxQQ0RG3feleiPwJwt3DLRH9cniRpkjhnisQu/
         EncrznHky/q++YJYM12E2HBYaeu5fh1CgRy7i1fQXPWHiQ3XzcLipGtjeezw1dSLanY5
         W61WWIuyVC+aWCVkM9yThvwodkzb5/kRUgDmt2L8ZVRx3H1oTfaeF1jqyY5ZvzA2JkBz
         0yzM5KcEgCqMavxKr6wAPdKBuwiPKH7CmJ7WeiiYHTG9f7SMwnCZZW7F9eqmUXrFB0Xg
         c6hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790610362; x=1791215162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        b=PZkE7mns5GW5YSJdiM4sHP9wLqDG0wjNCBVaNv/f1H42LCU3ckEHzDyt/hcRXIqX3u
         qnzHzpnevWwjBlMmObz/QnJvewjGZYIIXR5Bm8oOZ1JN5WLJEcWtxRSZO1CtdedFaes8
         SyZ59NGg9ElcTSlPYXrzILNXLHNg5TXNsTu14CdpmWp8VURrkPhacfnjRs6oMhQ6jDcL
         Q/A6FZxxToCesbOik6ViquOo6hPx61QdZ7+wjggVTcn7lXRR+ul+eiewXPH/r/9rQScZ
         yUsaY/PH7mo5L+tHOmStLz2qkw5soDulM86CKagVmIEEaUd17aQe3/lMjzaxVJ1VqlvX
         nXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610362; x=1791215162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        b=r1kWZ86CuCrPYbg9JHCjdD6kGBPGVFyIv1zBr72do+EesMUEk53+d7W/0+hqGAO9kb
         n4BIT2R1hQt/FINnUKC/i1w8VqmcepfskuOEtZuihq8/1GqpUG6qtiCRaXBQIYo3td+P
         44sM6bOGYAbydRy3ulPMscsTsIHJ29DIX9Ju8wS6tFUNX0XHivtXl99ch/f36DJvJ6Fp
         6lC3g7Iqh77pJv+BNUfJFkim2Q9Oyr4pyIm5bcX+ikvmMWvI2Z+LECXsjoE+ZUPW7rsu
         O/GNlLDEvzvXTkG8bn8XogNb7N8oIBvkp7lmOlNixehZEDOxfB1aaWVDz4ONPdI/LmPZ
         /2Sw==
X-Forwarded-Encrypted: i=1; AKwUvByvmmbWzfclcZc3OKRJDssSMpyz/XF3dVJtUYxveyLe4TMSVfPTL2He7ZfwqhLQqkvfcExI+4Awk68NKsM2VAA4Wal+/r8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW4wIr8G51U5BqMZcJFeRUnlB1NCgV5gyiFVCny31ZS2N2X2P5
	xOeWhnHe9V/ZhsOBS+6iUxc58DopmATLUcdFtjE3rEZajiKIrcpKv0BA5Yb/7DMR6+ZHfcZwvL/
	RKL8qJSyVqrNhd1qG9zob7tBXwlRnCsV6LzFbU/kw
X-Gm-Gg: AYBFou1ifpxrZtl2hddetqfB5HtxP/ARV9LVyTIpMW9dF4HOpOCnU8MBqLRuf0YSFUl
	Ol3BeYMBbnvjZZaufXpuNshv0qH6lt+5G64orScud6KDN0Dh8TZWNiU7YqYjNNaIac/38XbHzIB
	RMRkJD8YW/dLj7souiqDv8rhdX7dVzmxtF0eSbLjxtQriUGvwevSRzYceypGN9w4MV6z7Hz/HaH
	18JzqwAkC9LSpHkUqRw9I01zDFED0NE2f5HutdHcTHsSlFT6nFQ+IIttS3bCGQP9VWB7OYAoaeJ
	jl5+hR74eVhLrf11sEa69L/78bfDFPt2JaNshC0UQ/TPgB2d3Yau115bF3s4ninJhRf9FcEEz1m
	djx0v1jLfdnY=
X-Received: by 2002:a17:902:f70c:b0:2e0:8864:7f01 with SMTP id
 d9443c01a7336-2e088648100mr40903655ad.50.1790610361828; Mon, 28 Sep 2026
 08:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner>
In-Reply-To: <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Sep 2026 11:45:49 -0400
X-Gm-Features: AclHuK_fG4Ph2lyDB8B4vPRkrpFhgb007Hmd0WjDmDmNdvNtINrqpBqaiW-f0N4
Message-ID: <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:13=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Jul 23, 2026 at 11:19:30AM -0700, Song Liu wrote:
> > Hi Christian and folks,
> >
> > Could you please help review this set? Does this set address
> > concerns from earlier versions?
>
> I just realized something while looking at this. This doesn't cover the
> new mount api at all fsopen, fsconfig, fsmount, fspick, open_tree,
> open_tree_attr and mount_setattr. Without this the series is not very
> useful imho.

Thanks Christian.

Song, I'm still open to reworking the LSM mount hooks, but any rework
should really take into account everything.

--=20
paul-moore.com
