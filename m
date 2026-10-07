Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B604B7A52
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387026; cv=none; b=aGFBBkWnMHtvGnFqIflJuBZrywqincR2kHBQ4b685Za3fbhKH8eTA+Gge2tDbRlNcd5bmf5fUr7AOK6AEOcQyHbuLSB5f2az/okLPgFlNcYe5oHkYp5j3+YAutllSkln4aDzpEl1bvO0dtRXF2TItTR98qgci686U6/J9lG4n9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387026; c=relaxed/simple;
	bh=5kpnZ69rpIeJK7I/vVJI1/Sd58TTWJsQUlkCNqKOhyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+3jkK+5TBPTwkryXr7uP8EQoZBCFg4GLUJNEj+qiOMtIV1KBOSC07h50o5DEFzEJ03T6scnsLNjzEqh+d+kHzIKZs0rFZ2/6IOn229GkKAo7CUr4jeBMrp/kFF631hc9ZJR9bbu/sTOLpLX+Vbmbzj4rDuh5X3BcSgFzBfnnbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=YnRLPHMi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="YnRLPHMi"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b056d58f2aso14935157b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2026 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791387019; x=1791991819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxMsGMJoi15xhCerKdZHKbDFnpM/+Dr7cx060hZaVDo=;
        b=YnRLPHMiCGr5unS/o2c2EHvTVZtDLbNOMEOwpd1emzZ9X7nI/Gocgnbxthvcq+VLnu
         m48QAP1/vPGB9oDTrrKC7Bo+unLlCLwhVA0saPLhPW1jvSP4ewxx2JLky82lJE975xJj
         SCKdzRZDTnb2ISXI9sBkydjuiJhmpwYY1hI3Ey7dgIVXcoRJN+4tgwR3HB0ggPXc4MOa
         9NlCL+H8UUddsFhIjUecIk0R+RAZ8hkEGx4AbJspsUeCI08jOlOBawdMppoeN/t5r5Ur
         3RGfeYp0YyHPy74bXPTdoANsMdK8g5jDlk5C8I3+7FptOoV35TKSO8aDhYI4BtN+aCJg
         67Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791387019; x=1791991819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxMsGMJoi15xhCerKdZHKbDFnpM/+Dr7cx060hZaVDo=;
        b=MT35BMS1Z6e+aUEIVS6e2LKuHsuKxbAIhN8BlUC7oTFmXOIis4v33w+tC5/Qy4Hi3F
         a9uMMEJn1QBFHY2z/bKwicQ9hEMOhye4bE4ouTlyw8rQH+9ZV5bqt+jl3cJo4dL5e5OP
         rCPhzpoJvqxkKuR8E+BtLXvAvrGiy9Irbu6f/V/JtEAaNBPYEZPSWEzbB1sVCY2N1EPx
         lD7RpQVDR2YFqvpa8JNZwPOCPrjPBnPaVWeTZYamUR9xYyGrdaHRszjPZr6hfFbH1GIT
         NUdp463nuLqvOlJBSH2Wwd2qBFAkTvHfmtRKixgXAoZyBPk+nOBx8pZ7FZQ0dBAcA8b+
         YTXA==
X-Forwarded-Encrypted: i=1; AKwUvBxGUrOORKF676MY5Z64kYf6xm0fR2UGviWUaKD8ikxFMF2L0Vco/gYCxWlxQlV66FspGm4kNL0aE5OYGkDxYk/rHYQTQ14=@vger.kernel.org
X-Gm-Message-State: AFq9FYLglBoI6ufNNUjsXdbX0S8sHaq8iX7ZkQCVszd1vy5sABEZQE97
	xETc+ALSsyQZHey5WUySO7zRpaq8lWWpF4HVrrpr3fyj2KkFTOGnmq7LL2rHnFj7PGMs
X-Gm-Gg: AYBFou0Gfx+R0xp25p4IZTyz4X8hGy+4CAvdy4bvpsrn+9brMoO9Qkf2bIpaKmR5biM
	py04x3xbnrT21uoaJTUT4Diw75j7SrvNMqzT/1qnDFOLflCqe1aYJv7xagrRK4ySxhK/3dyfC2z
	GEd8neC2NAeH0wyAHRZN//7QVGrRLFVuB1B1m6NCwD/gMPs5hObxZL5xqkMvNCGz5s2tFZYzM58
	lT590wzzPt64WwYeXwKsQOaOcr8Tz8ZsOMEZkSUkC1UBxKCcV7Wihoop1keCdw74PH++NWAajKV
	dHSosAOeI3wGYFqsesFEBYU+ck9tV4dq7lWk0jZH+4QC4iKnr0Ak8PAZg3qkW7c0QJtVsW/hfhN
	tWJQWc564ZruHQuvWgstuv0cVciQVsBA4STgLUV7lgteO5Qdliw14aUD4oKzo7bRUffndSYGBQr
	EXKHuDasNCXgjJ4WTgelLVvndoXKal/fTNV3QPCGNjkEJLMuLNUULZiFBqwO7Ur6v/e/6W/F0bb
	hShcMlgYO5wUllntyigmewezOKa7GptYxwCJ3p6Bxs=
X-Received: by 2002:a05:690c:6b01:b0:873:5bb2:6c3d with SMTP id 00721157ae682-8b05b14e894mr18727417b3.68.1791387018749;
        Wed, 07 Oct 2026 08:30:18 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05a9b8806sm9897427b3.1.2026.10.07.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:30:18 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:30:14 -0500
From: Andrew Halaney <andrew@amutable.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 1/3] keys: add KEY_SPEC_DM_VERITY_KEYRING
Message-ID: <asZlNEFdvidvMdJ5@toolbx>
References: <aqyiCavj3xeNqyAo@kernel.org>
 <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
 <20260914-ajhalaney-dmverity-key-identifier-v1-1-01922dc1366a@amutable.com>
 <715249.1789718726@warthog.procyon.org.uk>
 <aq2VxlttdlTNlHo6@toolbx>
 <arYzQN1ViuiCBemo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arYzQN1ViuiCBemo@kernel.org>

On Fri, Sep 25, 2026 at 11:39:28AM +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 18, 2026 at 02:59:49PM -0500, Andrew Halaney wrote:
> > On Fri, Sep 18, 2026 at 09:05:26AM +0100, David Howells wrote:
> > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > 
> > > > This is great for discussion but what we want for the commit message
> > > > is just motivation and resolution.
> > > 
> > > Actually, I think it's useful that Andrew wrote up the issues in the commit
> > > message - and I think it shows part of the motivation.  The 'writing a fake
> > > /proc/keys line in the description' is something I hadn't considered.
> > 
> > I'll defer to what you all want in the message here, I found it valuable
> > but I trend on the side of overly verbose admittedly!
> > 
> > > 
> > > > I don't think we need all this just to say that /proc/keys in a racy
> > > > query mechanism for production, which is an issue for dm-verity, given
> > > > that nothing else is available.
> > > 
> > > I think at some point, we will need a system call to search all for all
> > > accessible keys matching certain criteria by actually walking the key
> > > database.  The problem there is that there may be multiple hits, so we may
> > > need something like:
> > > 
> > > 	int count = find_key(key_serial_t start_id,
> > > 			     const char *type, const char *desc_prefix,
> > > 			     key_serial_t *results, size_t results_size,
> > > 			     unsigned int flags);
> > > 
> > > Allowing you to do:
> > > 
> > > 	key_serial_t dm_key;
> > > 	int n = find_key(0, "keyring", ".dm_verity", &dm_key, 1,
> > > 			 FIND_KEY_EXACT_DESC);
> > > 
> > > This wouldn't be as fast as a direct lookup since it would have to walk the
> > > key tree, doing name comparisons and perm checks on each key of the type.
> > > 
> > > > And secondly special keys are meant for implicit keyrings so isn't
> > > > that all there's to it?
> > > 
> > > I have no particular objection to setting aside a block of negative key IDs
> > > for special keyrings that need to be accessed a lot - though I would make
> > > common reg/unreg functions that take the ID to be registered and, say, set the
> > > block at -257..-512.  Moving the BFP keyring to -257 and DM to -258.
> > 
> > To be clear are you suggesting I do that for v2 here? Happy to make the
> > change and add some reuse to the registration functions, etc. I'm
> > guessing its fine to change the bpf id since its still only in -next?
> > 
> > The only awkward bit with making that more generic is that dm-verity
> > isn't __ro_after_init since its coming from a module possibly, and
> > because of the module usage I also protected it with a spinlock in case
> > someone's accessing it while you unload the module. Could just use one
> > spinlock for the whole generic array, and drop the __ro_after_init I
> > suppose.
> > 
> > Let me know if I'm not following properly!
> 
> I just read David's response and I think he made fair arguments,
> and patches look fine to me.
> 
> David, did you have anything? I could pick these.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

Gentle ping :)

Are we happy with these to get picked up?

Thanks,
Andrew
