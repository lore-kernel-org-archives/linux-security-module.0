Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792689559;
	b=C++iAumzW1RLz4CY8z2Q43TfkzUUIZwm/pyTfzwj4meqLVuZoxk6+qm+MAnitjZDgF/Y
	 wUBSxaxfayCqJfpkVOzHhmI0NqMs0zyjr79qCGKImpQI0RV6OSUgk3k7xI65SZShRcH2u
	 CQotSow3lbwSq7XvcoiC7q725h3St+GRsC3qqZOk6Qz0mVjp5aGb6/sV6EU7rL18DQzTz
	 Oom0U2D7ZJxiQUWLmSCnqpH6hoS82+MSySLV5F+A+BnDMJr04Gku+8+QGc+sRW/CRe1aN
	 8ujtAYmMdtjHAwI5+ROVw5GATWeqKEIWrGmh8UMFwJuVN1w65LHOoaUJmglax+9rnvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BB37ifua8Sxb2GAG5iG+mcuA1PmZC21b7zD8v0nAGJ4=;
	b=eED3ppSqZpMNdRnT6ayr93e8uwGMBGZvQD8MZ/7+H9Md46/Sh+2krgrdp5OuvXavgYEA
	 DsJUJdbaLGn/EBneUVGCsq118fS7lVYI49zsyJwETc3jGi00ohBeXfyrGe44vT/bmPgt+
	 6zYEXWNR/zMcF8FxoISluHnM4cghNkpeYSQT2mAcxV96B6dm5P0yY+ZsEDFpdDYGqhBoL
	 DUIYI6FE4bpTJonQMCWvinNh4ul/grzmRK+dey9skhiXA3paOSW/OmON0BJUJZ9lVfLUG
	 TjU2ioTHvpDv8Rj9hwS7wj+xTXZEYiz4yXMBv3Tnlj5QMSzdxrU0h70Pdv/yB+/i6OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=fail smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16478606A31D
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 17:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16478606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd3310348d2so474651a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 10:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792689553; cv=none;
        d=google.com; s=arc-20260327;
        b=J5JWhMXsyRbIC+4lTZLj9wHLb72eKbzTn/zuxCBXZ+JXbh2EzwZ/lO0ZZ9TYST7Sde
         5OdkbsWBaHrdY7jWJFvW/0Hrkm/6T5dYlCKKWTJuYVc9X2hzIHTDnsdbrZ8ZeJer6VPG
         J66Sh2dRz3/Faj7Gzs2L95LjgS3rDr2BvMLBYq6eyfmBHuvRtEcK11DcNsdzAHEYN8QR
         PATbi+xYp6HgMViW4gxkGJydTsP7RIvZCJI48ZZpdURZnLbl4aKII0zgwiHy314ImO9L
         nTExcUdQcxlwnFMV3m/+Vr1IuElnih3vKDjZsmNWwtFK8drm5bA+G+0Eu/jOPXucHb7r
         coOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BB37ifua8Sxb2GAG5iG+mcuA1PmZC21b7zD8v0nAGJ4=;
        fh=exmlEB0q1MGxVOHf903qtkLaC5MWWW4qE5kiYeamJLQ=;
        b=oURohpFdsDKtIzdXg9PlM1LLE/Nb1jz9UHXehqPtWTS+n0im05MIYRloKYr38+rTTn
         dVbl73micZ9sXqW5n8oaYkRsESTWlRrMFCHfKiPbqoaFvbFjikzXxzLYtZL4r0Ds9YkC
         DwJfCGg2/8QyyfeM44MMGTVZAJUm0Kq/RHVop+xaCKq52M5QRhawej5ORH/h3+RqwcNk
         3BWaf+25m6rdOAn194IyThc737blZyH4GVcpm6zwumvS/G6GVWZkVhQZ7HDYJBpvnLYN
         b0pqwb4M++rhWhioXUL790ahiVZX97D0DqPfpRbfI7NVsiVPEpRZX7YeGKXPThjhoP9e
         9hTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792689553; x=1793294353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BB37ifua8Sxb2GAG5iG+mcuA1PmZC21b7zD8v0nAGJ4=;
        b=K1eIq/GMjRwymTiDRmvQUK4W8vEF3J66M/qREU4Pf5Dgs5jQY47GYeuFACctzhxRMp
         JVIwSc1p02bUGb7HGwOYlEo5uZFib/eQJhSVsSgYR7CG9iocSGXDcq05KcghSCfYpgwy
         tSFcUsS2z/n7aHILMoQ1mkvzB+iyUr4GqW8+qaZVoW1HBBwoVccXepzOQGzfx8z+oMaH
         MbnLhZnhS7e1RtF7WDLLDAdCPSOMm7nw6oq6jiVMYt2JckrcBnH+P1DSoy230ddk83Y9
         MOjI5cf98eAf0w7/SJq4HQ1j/7yH97UuyWDx6nIWaLQ0m7oBxCg7jZCwsTT1NW/Pj+VT
         1VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689553; x=1793294353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BB37ifua8Sxb2GAG5iG+mcuA1PmZC21b7zD8v0nAGJ4=;
        b=idgYKDXbrpI+CCtuoB+ALbnW2HyA8wUugV8kLtDnh3iykm/r9hmWTrS4nw5wEF707W
         C9+K5+vUHOqZwvhBHck/p83Fqo9NEGUmII/5uYyYkGpk2V3OzJHMZC1ZXov1EzPGfugx
         7WgccvzxkAW6bcW8rsQGpR7qYs2ri4YDdDlfL4IFbODE8CBRSQN0pS6uzHk4RThzt9dc
         GCZ4VRYp6qdWVFIsjday7tlqewoXx60yOZHTJDEowAmw2Ww3PpEYeRihtdg30R6Fslpl
         nXEoDjQke0iUmGtZjhpKNO5G5Xl4/paoucyauUCZanf2zDReaCo1P1WkgBCYH5i9cuDu
         WxNg==
X-Forwarded-Encrypted: i=1; AKwUvBzm6vYaBgwTHbxZI67aSFQXT6XdWeWfMohsBNlIvOuoekPcGwD5/xsn8ws4Dc7OhPVMHGgcLUGC92xdYFXR1jGkWmZERtc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjoGIZvczp8XB9zkxAtEbyt3FvZ2lPZxC6uPYeNq0bM7NRtISV
	sRrnll0MvCD2rbzQ3DxXHeOCo2R7DlTwMDIwXMotuKYRXmyXB6306+YKMV7/ZObmddBHc7hdpUI
	RnMIImKpUiuSjJNNQNKGjJUz1o8nlaGN9sfSSP2qS
X-Gm-Gg: AYBFou14KffcNWp48JtVKgMVs4RwF/hEdKtk37wjFcb+ZkTLYeATqjDrpL2RJii9Czn
	SRmJ42yux6JuX6Xtu4x68GTMlMg+KMjjr2PpwJL1sSvhYJEcOJM6fTCsjImBdlU3nOVgXSGjm6o
	ybDoQAalLH4dLnIiphybGLlWPvFNXKBXiqBcm6FnK8TfRxIL3WItFLZfLQtL4Axa1S7tHDV06kB
	ee92rBOhAuLpPV07/LiA/WPBerDI80XpVrlWq2C5Dcm/XO9m9lb/k1Qo9Iugyh4dTbIEsiyl73H
	o4MVc9v16y/mtIUN7lRoC/O1cX2Ds0FBnsVqh+FbevCl+R0vzuW9fmL1yhFw7KABTrlelvGRgeS
	t+pbOdI9xVcVZgo4qbCWgez5lJ9bA6wlDQFMG0CVmxeYHKGUOhxsrYdctrei72IK+Gg8m
X-Received: by 2002:a17:90b:514c:b0:3ac:95d7:2f95 with SMTP id
 98e67ed59e1d1-3ada6d24c14mr2208639a91.20.1792689553067; Thu, 22 Oct 2026
 10:19:13 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com> <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
In-Reply-To: <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Oct 2026 13:18:59 -0400
X-Gm-Features: AclHuK_mpvVbVbsjXsFY4C_2Z-Hg3ACXgqMxfwiNaJKHEvEnCJIfbBS66y6uEck
Message-ID: <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: Christian Brauner <brauner@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 6:19=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Oct 21, 2026 at 12:51:35PM -0400, Paul Moore wrote:
>

...

> > As far as I'm concerned the decision of how IPE uses an IPE keyring is
> > up to Fan.
>
> This is really not an argument. Manuel posted an RFC that follows two
> existing in-tree keyrings to the letter. Fan asked to deviate from them.
> I explained what that costs.

I felt it was important to show some support for Fan, especially as
your comments came across (at least to me) as particularly harsh.  The
strong reactions in your latest comment only served to underscore my
concern.

> > Of course, fitting in with existing norms is important,
> > but if it causes IPE or existing IPE uses a lot of pain, that can a
> > good reason to diverge from those solutions.
>
> Which pain?

As I said before, (emphasis now added for claification) "... *if* it
causes IPE or existing IPE uses a lot of pain ...".  I intentionally
did not make a claim either way.  Once again, I wanted to provide Fan
some support in case there was an issue and he found himself in a
position where he had to push back to preserve IPE's model.

I think we can all agree that upstream kernel development can be
difficult at times, and not just because of the technical challenges.
Working in the security/ space also carries its own struggles beyond
that.  It has been my experience that having someone stand up and show
support can sometimes help make that a little bit easier.

> > These days everyone is
> > going to implement whatever they please, but if you have
> > needs/requirements about how you want things to behave in LSM land, I
> > think it would be helpful to engage with us before you make a decision
> > and then start pleading with the LSM folks to adopt your approach.
>
> I'm not pleading with anyone.

Perhaps that was not your intent, but that is how I read your "Please
don't start breaking an established pattern that works well." comment.
I believe that is a reasonable interpretation.

> And the engagement you're asking for happened. You just didn't engage:
>
> - You read Daniel's bpf keyring series yourself in August, Cc'd the
>   keyring folks "for obvious reasons", and had nothing to say about
>   the model. The cover letter spelled out in detail that systemd would
>   provision that keyring the same way as .dm-verity.
>
> - On 2026-10-11 Manuel announced in the KEY_SPEC thread that he'd
>   propose a .ipe keyring "modeled after the .dm-verity keyring" after
>   "initial discussions with Fan Wu". You and linux-security-module
>   were on Cc.

... and you are seeing the engagement now.

> As for "everyone is going to implement whatever they please"... In May
> you told the bpf folks that "we just need to be willing to accept that
> we have different needs and show a willingness to accept different
> solutions as a result" [1]. I don't see why that shouldn't apply to
> systemd using BPF LSM.

I'm unclear on your comments above.  Obviously out-of-kernel-tree BPF
LSM code is free to implement whatever it wants within the bounds of
the BPF constraints/APIs, that was the intent behind my "implement
whatever they please" comment.  I guess I could have made it more
clear, but it didn't occur to me that this would be a controversial
statement since it is already happening today ... ?

> Frankly, I couldn't care less whether IPE chooses to model the keyring
> the same way.

That wasn't clear from your earlier comments, especially considering
your tone, but it's good to have that understanding now.

> I'm confused why you have to speak for Fu and why you're so
> defensive about this.

As mentioned above, I wasn't speaking for Fan, I was speaking in
support of Fan ("... the decision of how IPE uses an IPE keyring is up
to Fan.").  Perhaps you didn't intend your comments to be received as
overly harsh, but in my opinion they had the hallmarks of anti-LSM
bullying that I've seen far too much of over the years and I wanted
Fan to know that at least he had my support to make whatever decision
he felt was necessary.

--=20
paul-moore.com
