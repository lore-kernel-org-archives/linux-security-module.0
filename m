Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785137F8BD
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634951; cv=pass; b=tzwWyar67pOQrE5I7A+uTIz6hvl4bHzJ4H5jP+NIxVUqcZgTKqH6BHooXX0tV1FuQSiP//7lHAAyFmy2srgRt4usmaAEgUOqj9Li1nNTtMAZmavKV611ygTGy0tD9mO8tArKdl71F68bl1beW9WXbNaF8qOF2f8rsoJlIEP1sfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634951; c=relaxed/simple;
	bh=F1/l6OgOeI+x0F5SY6s6nggLxA7Jgat/gfQduPeGPdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY+Wl7lDTriA9MTKyu5p27SaPsPDmia2iSTQmsynWhmK28bKVJFGaNA4LzzVbnmZ3iAP8IFubTPWY3MYNc2gtosLvwCP5ZYM6q7kveNolJeaxNjAUmmQp776XnKoG950U+lPQdu/Izi7jE1DXPuD2D9ZlMqITodVYx/48SNVYbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NR9L4Po3; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NR9L4Po3"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88286981a36so1191835b3a.2
        for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 15:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634945; cv=none;
        d=google.com; s=arc-20260327;
        b=cj1KJVwqYmUuI0pVBWx1364sWM9cWM4dUf0QkQalFz8+6jDyGMjs0Y4jrgUKFRQjAY
         M/cDjItvIg1X8x0BYMGI3ifhuASw5g4ESaUkjq5xqFeiCS0lcaJgCBfYthjuQKfs0XxU
         nalsYb3vrvZVN+FX8o82npYoyFUVv4/qhtJnjZojqMKSrNL4flSJRsC+Bfjsi+fHY0ee
         8rI03Bhpb6lE9+ISH0eKV9WSAXQOEloMtcMQU0GWAyC+dx02HnWFTYDt3cvObHGKq+m9
         q0zLCSwLu9s+e4bjoalC8DztkP308BFDF4qabSTzH1GjTRIu522vMq9Zmoh1xK2jPDHZ
         MznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        fh=EZRh1mGi1LZBMVquoRbpOPRZC7/xNZU5pGR9VkJDNcU=;
        b=jXUwVkmag14QtSVAqhFC+SFPotiobrWyszZY++nWleH0Qi2NWeceeWjLuHykFFGJE8
         /P2dKN31sxDTo7+mBiDuC6IM8EM1h3YQrQiEHVWM1Ig7/Uea9JkgkhURQrEmIqYr4wlC
         Nux2vlVfzhXHoABmXFh5iXsZePgiQEyoG19/rZB4XWUBr1nvbzHoNB9YjSD3+6f8RVtf
         HiAf0RJywgdyxjkMQ6aTXxvLdd/cSNF/7Pjo5Kh1h2G9aLiY5tysrOaWtI7u/p3M3i2y
         Wcr+z3sLRI2BAbGrdPqxVXh1Z32Pu8KMJSMRo5EUO6yNu3mLKqWtjJ+utbaNVxyezAEd
         /c9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790634945; x=1791239745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        b=NR9L4Po3vQXP6g0r94eMldHIKgCwIYPrRdJQnQ1cNlWDGR7VxPwpZwg/o6g2GknvXJ
         hZK8JlnEZuTB92E0nt2F5JPkm6hUyb6O6R3kA1XJwP460fF6JGF3VpXTu20xE23kWKw8
         8pEk3zibP3yIt7qG4RBLnHdmOVdeSyLO19mpVhKlg/lqQ1rm9OWLKdXEMkH7s2VihsFI
         C38y+dnqic6LoBy64Az19+bUju4piUcB8Ra3+ZHKU3IKqybzKR+9sjML3KZz7RxMxqLJ
         O+WtAOk6R1bvcX5MER3qRjQjdEGsydaLcKGSE51xmCN8Kv66/i3+4ukaKVOdVrJyi1A0
         Q9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790634945; x=1791239745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        b=f/gjqh5aLW4KHhwTfb2IHp7jazzT3DAnxDojqddumCStx+tJib1rYJk75oDbNvv/mF
         MEB4CSolcfGTS04FjFsUZXv83B3UXhOqd6U7TDNHv5PmGEZTM1+KchnZHG42XN6HKunq
         JIttH/rpRYq+Z0b/LR5wB+vfAacMqDQCo5ESQo5zAZdZU+bPGTipbwolckEw0+Y2lmmQ
         tv8TfVAZYTs8qlCOo+T5lBrVOLzEpeYCRvtkUYj801ranwGCQgHlZVCx+BoumXIqv9rY
         FX7vdG5sUWMn3k5OkJ3anCcpqvnDj5fcoZmLYcc3GUELDEqvZQfFUgky2QUWfq0mFGjt
         e5vg==
X-Forwarded-Encrypted: i=1; AKwUvBz7HUGog5c3LKYOhC/8knDP6N4jfHjTyOZRneNNKC8URxbARRMNz0parZaA4V7EThsHtSi2aNUClcPiGnEGInLxCzJJ9Mw=@vger.kernel.org
X-Gm-Message-State: AFuF++leLNGLO+e9gbUzonk7aNh/CGMkg4kf6q6BBGC6wAi9Ui1Z67un
	eXeT66+Qf9pwQk7k/Viv+Cv3eWGWKjh/huCs3cyAC8tueptJloDnC89GCXrrxohjO5KXQXulTje
	/S0R+6/k5Qa1aw1Ygh/qMWCS4MwdhAFGXjAUudtK1
X-Gm-Gg: AYBFou39L7JGPSdbv1mzNKH6n4EwiC0zwE2s1+M50R7Wc+VCQLz4UpRJzSyJ5emQ3Nx
	ir/hkldJrl5rVc/EcLhxUPajvJY0i2mIM0jFwmUb52NznuX7b1YXPuhKrsbpsUk704N8/CxJwH6
	+Mm4wshzJYQSCuNj5lI2GZ0XXz7eCCi3ZFLeO3FWM+wRJs5/grMfV40/g0yM/mMxs0MEatocdZE
	dpKLFisvJnFoo+Vk1+PAJ/D3QV9ugr7qHTuAYeIDSQY6vnlDpH512b8dTsA6XzB/yWyWBPZ/EVS
	/jZ/dBBSRZZZr2Dhfm9PLCFp9M8MXooPAoIKlUxIYcE4Hrp7ttIaqLP7lgYCBnCTKXTxddYoeoO
	Od/yHVP8b+n0=
X-Received: by 2002:a05:6a00:887:b0:878:3811:236 with SMTP id
 d2e1a72fcca58-87e9f82448emr11926596b3a.50.1790634944751; Mon, 28 Sep 2026
 15:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
In-Reply-To: <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Sep 2026 18:35:32 -0400
X-Gm-Features: AclHuK_FsGNbZ4FGUjZCK1Oz0frv6FIewmN7ZmvuDUc4wvtZdc4sm9Pj54ffJr8
Message-ID: <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:00=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Hi Christian and Paul,
>
> Thanks for your replies.
>
> On Mon, Sep 28, 2026 at 8:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Sep 28, 2026 at 10:13=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > On Thu, Jul 23, 2026 at 11:19:30AM -0700, Song Liu wrote:
> > > > Hi Christian and folks,
> > > >
> > > > Could you please help review this set? Does this set address
> > > > concerns from earlier versions?
> > >
> > > I just realized something while looking at this. This doesn't cover t=
he
> > > new mount api at all fsopen, fsconfig, fsmount, fspick, open_tree,
> > > open_tree_attr and mount_setattr. Without this the series is not very
> > > useful imho.
>
> Yes, I am fully aware that this does not cover the new mount APIs. I thin=
k
> those are orthogonal to the optimization here. This series is very useful
> without covering the new APIs. Users from multiple companies have
> repeatedly requested this change. ([1] and users requested this set).
>
> If we can land this set without covering the new APIs, I am more than
> happy to draft new patch set that covers the new APIs as a follow-up
> work. Therefore, could you please review this set as-is, and see whether
> we can land it without the orthogonal work covering the new mount APIs?
>
> > Thanks Christian.
> >
> > Song, I'm still open to reworking the LSM mount hooks, but any rework
> > should really take into account everything.
>
> There is another question here. These new hooks do not have any in-tree
> user at the moment. This appears to violate the "New LSM Hooks" policy
> in [2]. Could you please give more specific guidance on this?

There are LSMs which implement mount level access controls, you've
been updating those in your patchset :)  I believe that some of those
LSMs do have some (full? needs verification) coverage on the new mount
API.  I would expect that a patchset that adds, or modifies the
existing, mount hooks would also update those LSMs accordingly.  From
what I've seen, you've done a good job updating the individual LSMs
thus far, but if you have any questions or are unsure of what to do
for any one LSM, please ask and I'm sure the associated devs will be
happy to help.

--=20
paul-moore.com
