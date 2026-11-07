Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794077276;
	b=n7BZMMZfPGypM+3Hpxm2xTzAplZvmo1XHcb6Jww8BrVhIXdovSujk0ZnXZi8KpfLqQJ5
	 E0DL6nLWbJ0HGNR+ERw9XWk/HQAVVJfV4JQY/pWubgise5qP4JJZMfC8cgm96N7Cfcg33
	 cOcx+54yZSjsoxRKHNU+ROGSSvuCv2IMsG90jlkxAEbfHffJb2OKMSaFfypRnJILpeC7B
	 MzIx7M5IubPiXLkDkcw8YZqZ1ukNRiI41f5aQpE2mzjFN2bVTr9kWHOpDuEnWnau1dp8I
	 FzDVpiODHo/FqKsLALeskvqDP0IFjt9fJUv8scAyV+ObX7cM8R8SIuZ0qsSGJeCEp7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
	b=EPY9UMQhdCunROPLlmXVCkWjjttFsw+upnSGostphstyE6AnXSHCL5NcpWshDxHNX8/a
	 H056Zt1fge+i++NeuCPkz3WgAcPgLdZmeINPj64USk86g+I6YV3PAU+jXXAZZZgDGD1Pl
	 JNsHuwiRNZUKkamzWWJk7iU2Tr92NUxamayJoSfa71jJFmMBEKBT4TvXAtUE0cTx0qChQ
	 N+Za4BVik8GMFmmBUGrkyWSsStLwbgACUlPXuOhUdhvnYSatBWiQqKd1vtB0JvhxNaAR1
	 hEMPPpOtEr7DtdgjaRNVZgmkUgVH10MovP7j3Bxn1GA/WaUazCgtZ9E51V7xSCERNqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jDsWkgNe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF69606A32E
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 18:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF69606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jDsWkgNe
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so923630e87.0
        for <linux-security-module@vger.kernel.org>; Sat, 07 Nov 2026 10:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794077274; cv=none;
        d=google.com; s=arc-20260327;
        b=jywgQ7AC2psUuLu512leke1MBVYRlfFuwt/YzUxz2wFey0r/FywEmHp/XyCVqAq/vd
         hry6ELARIV1tE/RriDVU46Tgc8VvAlFP9rGm9of/stFc08PkrPMQY0C0ybkMUZG/tyQM
         JfVa83cog9ZaU+xLwpgszaqTA/nt18kGXz14FKhgjZycEjRiIYSjI5HPPSYGqu+NPWDD
         J42qcVzjQJOs9TfudRZ4l69Ch4IYT1+LSCHVgIgfQk9VIh/aIA0JZ3KuGxfzzic3J9hV
         6blF+MbFUvwC4unUgeXQS6T7vjW6Lws14fKViD69ppn06eCv8VMLngsLlPM7Qo8zCx5E
         elpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        fh=MjMCC/1Np7jDAXby/WeEpbqnTxE4qb1gncP2FMXXtgc=;
        b=qJPx177UVYaHrM3ZE+zKkabw4j6csgw4m+4Jlr/QuL+h2D2t7DZO5RiUV/smaglyEl
         SgqblS1mY0GWwP4/koa9RLfrY+mh17hTaMh65LfRAdDXZe0eby50zukGpZ0RbVbrgQN/
         2xV8t5XQjE9zQqHYDhSsIkGhlkxqTISDr3R8Gsrhm1k0XYUmc0K23mOp02G5g0vM/gKn
         JYJFfSgVPFWsGMnpLNaUl3pvY/1PLksmBuK/MziyJfOFsqOCDrZWURM1vVlfO2ds2+rQ
         ahxgVCBZqm6xN/K8xZH9S0Fl8qaR+/nKCcu6MvYOkdlTnrFqNmqbSUi9C4FKCJkDM2G2
         KK2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794077274; x=1794682074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        b=jDsWkgNeFsbdQ7qKqbpHSGOmDkfyI4OzDS2pJc6+Irn0QHpBxG9wPbmRTDmNnDdzS5
         db8t7KSVAGcHE/QtRbNhFDCWnX4uqUr1mEeZuLglr9YUDK4k94+gZZ0e2v5XDqaLBMAu
         GF2mKtLq3tPj9IBZGN3w1gGTAF0jFrsZMFCKcXAmKrirJiOIjEcuysNg1l24IqICP4gV
         r2UQCTmuYiVAi+q/1GU8UDVYE1+IZodom/D3RIz9GtMMMdasHTqHTXmlylMP0IcXnVJO
         5lWPTzglrmuISOXtwRoPqefa1QyXnIQk56sGTTb2Rf1nGsDNJzcZ5BPRF2XDpKcZZ3TD
         g2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077274; x=1794682074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        b=BqZuexq4XM0stNcHHYiMSIS+6c2gP+OiH8her54hCk0rREeijQdJft92VBm3W3Ghi3
         cZIrSRxUFdgX7UKhDdcf2mQz43vNQvApLWA0aGGraNCo/gzKR+fIFS+pR5GaFPp9fUkq
         GSN5oTUaJ3kWe+JQdHPqoP0+NTtrGlPKtIeDRqvwMyJgMLq9mZgcF8exuhgB7G0nnE99
         dSqHo2NXc9ATRG3LsWKphHYEvvdu/1LFcUWr54+Sbiv19H5rV9G8IGMVdCPcJGZ185oC
         ByQvFtoJVfLrQMsE4TadA5SdG2FTUVw5SoKs3J/abqd4RHpgZL2Uio2Pf9ym1c39jGoe
         ZYaA==
X-Forwarded-Encrypted: i=1; AL+hErEu/bePuzVOj+zXRj2vmvOKKzGw6Zs2UofR5HQlBmJjXhUODlCzZucSxplY25j0wOMPsLOYF+/yTxgg93SfDKBRpIVkwYQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9heW2MNuKjFoeZ04HkHeSErw783cCGt0u7TN8isg1+dUfH6w3p
	+bCaHinojpjeZ1HrA2R6ggcSb4hAG5bB+CFnQea0Tncv7i75kpQHdJUyzpAQ3A4/m+3SW++zG2Z
	d12FTBX9dKQVNGKjfY4UTfyFsYkovG2ZcYao0tMvd
X-Gm-Gg: AYBFou2hqAiAA3Te5HxUw2v+Ae8/d+YYzSWeXynXg+63AR3Ip45IH+a1JQyNMKdsIay
	vdEag2itz/oLJdSPp8MCBx/WijIkNjxCTwJfuVcq9plsEoHOHY6DGDUUxEovFpR0/t6ym8lvbNC
	SloMNHEmwty7Hr2GvgqLiZw8oBOwpaEl7OyQWt8Uf1MFvutIzUEFg19nmVYZgTWnu9NgLX9Uf4T
	caGIg8xmvOvPLVdwAk1L6EzHUInO+iIwkamjyVSQvZ6foCfiYmRcMpy+NCEt4WRSM/LSx25kI6v
	NrbJn/Udx6MBjuAAeVlX0EcSzOKCK7GKKI6l0ZItaY1XQW8B1vNhGLjRM4+bMa2J3/MjFdVI42D
	cg55lWgm6Zmv+5/Q+mrCMg+aJM2bKnzPP2Q==
X-Received: by 2002:a05:6512:291a:b0:5c0:ca1:9dd7 with SMTP id
 2adb3069b0e04-5c00ca19f2bmr594320e87.35.1794077274068; Sat, 07 Nov 2026
 10:47:54 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <20261106-befreien-addieren-eislauf-e09212803534@brauner>
In-Reply-To: <20261106-befreien-addieren-eislauf-e09212803534@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Nov 2026 10:47:41 -0800
X-Gm-Features: AclHuK9s0dgg3FDVqp4WbjYQnA0hebDpEpxOAgz_VjLjRP_HfRjeTpRH9DX274k
Message-ID: <CALCETrWa1SBLcb5oWjqjgzZvKvCoHjmYFk=Lf5ytEM9uqm5jYA@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: Christian Brauner <brauner@kernel.org>
Cc: "Hallgrimur H. Gunnarsson" <halg@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:13=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Oct 28, 2026 at 03:56:11PM -0700, Andy Lutomirski wrote:
> > The whole unshare/clone flag situation is getting out of hand, IMO.
> > And this new thing makes logical sense but is really about reducing
> > exposure.
> >
> > Perhaps we should instead have a small list associated with a userns
> > (extensible in the future) of things that the ns's admin (i.e. whoever
> > has CAP_SYS_ADMIN relative to the ns) may do.  That list could
> > include:
> >
> > - Create loopback with sensible defaults for ipv4 and/or ipv6 (i see
> > no obvious reason to separate them)
> > - Create tun/tap interfaces in that ns (and attach them, etc)
> >
> > And add a very simple new API to do these things.  Actually, the
>
> We've had this idea in the past and I think it is reasonable. I had
> always thought that we should expose a system call to create empty
> namespaces ot any type. Usually I'd be excited about that but I think
> that point is a bit moot and I'd really like see whether we can turn
> cells (or whatever other name) into a first class api.
>
> The problem I have with the patchset as written is that adds a lot of
> moving parts. And yes, I find the CLONE_* and UNSHARE_* flags plus
> sysctl to be suboptimal as well.
>
> So the TL;DR is that CAP_NET_ADMIN + userns =3D
> CAP_NET_PRIVILEGE_ESCALATION 10+ years later. And this patchset wants to
> put it back on a leash.
>
> So why isn't an aggressively stupid solution to this problem to split a
> new capability out of CAP_NET_ADMIN so it covers the absolute minimal
> set of things that should be allowed instead of doing effectively the
> same thing but split over multiple apis?

Because we don't actually have a clean way to make a list of
privileges that are, in theory, harmless but are hazardous from an
attack surface perspective and assign them only to tasks that ought to
have them.

But maybe we should invent such a thing.  It would be very, very nice.

Other than that, I agree with you.

>
> Anything that is reasonably advanced should not be the kernel's
> responsibility to delegate. I really think the old privilege model where
> the kernel grants control over a whole subsystem is inherently flawed
> and is much better replaced if you have the means to let userspace
> services grant and delegate resources.



--=20
Andy Lutomirski
AMA Capital Management, LLC
