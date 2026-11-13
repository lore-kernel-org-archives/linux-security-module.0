Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595189;
	b=yvcicgIod6mk3aRXVTjVqs41qYAWNXG0f4MIKmosHy1Wjwo2W1rGR6MV/xMdKf4BCJwe
	 t+zqKgW6ietFHBTHtVX7gOaFxdxpJmBqKA8KxJdZhVFqtLm40ND9JM+efAbwj119t0Nho
	 tLkLM3ny3bWLeAnnMV1+JoVeYv0P3YarddiBYFFyHqFkcaDynEmN/TWI1dsCw8Gh5qUs9
	 qBN2x48Qt1+U0b+MeuuYAUYOEY9r/f0Np30N2eBenzOA9x/XfFNZJQMNmgYxSjP5sorpy
	 EK5l3l8RkoBPAMpld64YllZ4iBznomLURtrdChp6aNa/sl3aPYzCGPerWqrcBXct93Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=3NBWFEB6FU4/z3ljBBQ8NoiqjrMo0KVomaOmiAC4b50=;
	b=hDdZPX4WBiYSOu6BS2Ifj6DmKmsG63MIvDK3XUC/JsMFkrIWvnncLO/zwXm3GlQ5COIJ
	 jJZLBhvTmR2CbtBegr43GMYRppfaAgyQO+zR4yatXU1AbH+DSCXOR4Nm45AgSRsC/YEi3
	 C5UxbnAGQLM7vOz94eSLWDdexWyolHjEvsQwYALETUEWHZLp3WHyhyrTPmxvggf1yOpvz
	 w5/LTyB1hw1uEIuk1e7MWk/EpDcsUdijC8lwaDXZKp3mtnY3Bks+sIiMYvbo8BWQTRUYj
	 39+8Q45y4qD6gBwndi/FMnnjE4t40Xm4kT+9MS1y/9WBPQqDDWSiflTBEq30vnII84g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qV+oc8d0;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD57607188E
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 18:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD57607188E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qV+oc8d0
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49412eb1474so643916f8f.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794595187; x=1795199987; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3NBWFEB6FU4/z3ljBBQ8NoiqjrMo0KVomaOmiAC4b50=;
        b=qV+oc8d0hSgnBdxOfdlcbt3gZsZIo6yoeaCK65K5fkRU+FjSHaBWnHZSFnQ5tVF8Vg
         jvMUiJnk/8K/QN/vQPKBYvKhu6OQs7B/6R/V7mKggi1e3HVzBX48JKU22vy6fWVCyjo7
         FNYnSx8KjCnqHu0aEsu3D+RUa5t/P3Vhbbz21efPcust5Tr8FbSo514Ct2BjzZJlbLoF
         Vg0c0sVAaqwoEVYf6es5Y9I1CzVGo/68ZPXtuNvkfpc8dkxLQbV3tPXdcU27Ti+dg+jT
         Q8/gnsRcA4KjzxTU8cAOtjwMEr8OWiR3Kwcx4KyG9Y+RpMFOoRJt8MI22yzCx+xpM2rQ
         URJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794595187; x=1795199987;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3NBWFEB6FU4/z3ljBBQ8NoiqjrMo0KVomaOmiAC4b50=;
        b=Uda5Fc9nzDPPvvkf0LDuh8R+ZxUs9TaiCt7pOfmqgqwLTipV9/svJzjiUxllHWgYgf
         DzFxPtfAy9Hug342lzkAd/WP9kRpuSP55Cn7E42afvlcPYnb6sevlN630OOGaSYPHEb6
         MOh4L1nOZ0ZVq4YHTZlaq7UoeMH6rj1OF3mOWDcChbrQAmImfp3GHdnkPd+4aQ4f1LhC
         926pJikRr4QAKSeU7HPX7FbYk3ry4N8d/o6eO+8ZXDfu+UlCbRFeHsOTyU6rp7lxS0wD
         sFIkPzPmbGtMv13RbYBAuX5XDPtmsxsVBcT6fZPBOB0zixgVk3N3k+SWCbdAJ5Xwukhf
         CwXA==
X-Forwarded-Encrypted: i=1; AL+hErEY825R4UJJJS6HCmyvPRVyXT5BFKj+75WPVIFBA9ilKUOX+ppaVC64n5G7usSo3plB5fexACO1DXJSZOjV9Za3GJhccfk=@vger.kernel.org
X-Gm-Message-State: APuU4Z85SzS17/xmUowlDfe4jNc1kLEsWcBedy+WKTeFODB4QyN697Oi
	Qpa5AEbsS6HW/adWtXG9AvhBN2X6ddcih2PheWbR3Q3EqgTK/01El627
X-Gm-Gg: AYBFou3VVGo0q4jogcbiE+XXlLlEF2+6l+71HcK/xzeJKrdVubJIyoNygl14FIGJgVv
	Lhc+Er2DXMNC58NX1Mel7eGKfFeahUcP5Y6RoZ9g5UHu6Z+3Eetpac6hsXGTzaPKoczVzV6+nrp
	NChhYW2j6uBL+M4G3MOA19d8tfMZ+S2hE36t/JSt8uQemtftONRp+CPf6JE6yuHBbLwe8a6HWHc
	oIvjoOhou98EPMck5m7iEHeq6x3kIGaXmfLAe3/faXLGghUtdvYUBEh4LgirsPW0rFVqj2eGAvg
	bDzQFA+aIT8tJx/miMrJRuVVXrFel493Tgtlbt4rmWnoEHj9vv/iHF84gInkiW+hFuF8DFvb8kK
	1Peqz9f+aVgq6ijpVTHV9CrdHiR+5lMDJBv45MWUZXRc/3YCt7J6LE1mqtwFk9vPUgcndKhwpaG
	GcX7IxF1VFv2A3DAbfLN8QRoD1Tnus7f/rwCsQOPW8T25fY8rKUFwt2spUU2T0TLdSG28FhzL+g
	glZ+ITp40uFjuuZQ0trGUtu6EUuaBNWvFM4II9NNcHM/IwasTsui59aG7MEpwaJzs77DI67+eB4
	jJFZNHNpRVoLVJeh2BVgctC7iWACcwLGOhpasgpGnIN3bfJiQ0IHNQ==
X-Received: by 2002:a5d:5f91:0:b0:493:d5f0:4e4c with SMTP id ffacd0b85a97d-49c723fc45emr7653677f8f.23.1794595186940;
        Fri, 13 Nov 2026 10:39:46 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm6346363f8f.21.2026.11.13.10.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:39:46 -0800 (PST)
Date: Fri, 13 Nov 2026 19:39:41 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] landlock: Clarify implicit handling of
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <20261113.7a962670e000@gnoack.org>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-4-2b405fc1b3aa@gmail.com>
 <20261113.Ahzeu2seey4e@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113.Ahzeu2seey4e@digikod.net>

On Fri, Nov 13, 2026 at 12:28:56AM +0100, Mickaël Salaün wrote:
> On Sun, Nov 08, 2026 at 09:23:51PM +0100, Günther Noack wrote:
> > The LANDLOCK_ACCESS_FS_REFER right is handled implicitly in a ruleset,
> > but only if any other filesystem access right is declared as handled
> > in the given ruleset.
> > 
> > The old documentation was still a remnant from the times when
> > filesystem access rights were the only access rights that existed in
> > Landlock, but it became misleading when we introduced additional types
> > of access rights.
> > 
> > Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  include/uapi/linux/landlock.h | 17 +++++++++--------
> >  security/landlock/access.h    |  9 +++++----
> >  2 files changed, 14 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 24510e5d8479..7e38b9d1bf12 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -22,10 +22,10 @@
> >   * enacted.  Vice versa, access rights that are not specifically listed here are
> >   * not going to be denied by this ruleset when it is enacted.
> >   *
> > - * For historical reasons, the %LANDLOCK_ACCESS_FS_REFER right is always denied
> > - * by default, even when its bit is not set in @handled_access_fs.  In order to
> > - * add new rules with this access right, the bit must still be set explicitly
> > - * (cf. `Filesystem flags`_).
> > + * For historical reasons, as soon as any filesystem access right is handled in
> > + * @handled_access_fs, the %LANDLOCK_ACCESS_FS_REFER right is always denied as
> > + * well.  In order to add new rules with this access right, the bit must still
> > + * be set explicitly (cf. `Filesystem flags`_).
> >   *
> >   * The explicit listing of *handled access rights* is required for backwards
> >   * compatibility reasons.  In most use cases, processes that use Landlock will
> > @@ -462,10 +462,11 @@ struct landlock_capability_attr {
> >   *   This access right is available since the second version of the Landlock
> >   *   ABI.
> >   *
> > - *   This is the only access right which is denied by default by any ruleset,
> > - *   even if the right is not specified as handled at ruleset creation time.
> > - *   The only way to make a ruleset grant this right is to explicitly allow it
> > - *   for a specific directory by adding a matching rule to the ruleset.
> > + *   This is the only access right which is denied by default by any ruleset
> > + *   that handles filesystem access rights, even if the right is not specified
> > + *   as handled at ruleset creation time.  The only way to make a ruleset grant
> > + *   this right is to explicitly allow it for a specific directory by adding a
> > + *   matching rule to the ruleset.
> >   *
> >   *   In particular, when using the first Landlock ABI version, Landlock will
> >   *   always deny attempts to reparent files between different directories.
> > diff --git a/security/landlock/access.h b/security/landlock/access.h
> > index f9eaa2f53686..c4a81f7dadeb 100644
> > --- a/security/landlock/access.h
> > +++ b/security/landlock/access.h
> > @@ -18,10 +18,11 @@
> >  #include "limits.h"
> >  
> >  /*
> > - * All access rights that are denied by default whether they are handled or not
> > - * by a ruleset/layer.  This must be ORed with the .handled field of all
> > - * domain->layers[] entries when we need to get the absolute handled access
> > - * masks, see landlock_upgrade_handled_layer_config().
> > + * All filesystem access rights that are denied by default as soon as any other
> > + * filesystem access right is handled, even if the access right is not
> > + * explicitly declared to be handled itself.  This must be ORed with the
> > + * .handled field of all domain->layers[] entries when we need to get the
> > + * absolute handled access masks, see landlock_upgrade_handled_layer_config().
> >   */
> >  /* clang-format off */
> >  #define _LANDLOCK_ACCESS_FS_INITIALLY_DENIED ( \
> 
> This is good, but it should also be extended to
> landlock_upgrade_handled_layer_config()'s and
> reparent-exdev_layers_rename[12]'s comments.

Wow, good catch!  Updated.

Used the same wording there as well, "...as soon as any other
filesystem access right is handled".  It's a bit verbose, but it's
unambiguous and I'm hoping that we won't need another edit to that
wording.

–Günther
