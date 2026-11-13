Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599100;
	b=nvEqMvJHS+dn2rFyeeQoGL8PWxtUMcFatRdbgDXpuTG28i/rr2bTXZ36RXlQ7xhVhSXt
	 AtoXnj6jt9plBWx7xhc4XV3GFyRUYwHio5A4WscDqL6HDmNCo7XNfucmWu0D/9cVM1hLL
	 5jCWw+plyFMLMuE/fewY97DjHKJp2jNevCqPQJ6Hn0LXKOFvFjFzIPXj1H4hcx0/3x3S5
	 01d3lT2ZJroH7ajKedj01sSqyYO54nirLPO6JVduCjuB7+okK+oEec4ctcXsyXd1HhCPL
	 1+9BW66ilYHal2ENHwq8QP/Fy/eKh923mP7hP9eOQO1XGehTf2nXlVZjAf/1QhyvGqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=TSQaVzf8K6j4RVfK5HDz3FjLKLxGcucq+FqTpajAUEk=;
	b=HAFggPNCA9RgbTCv8DozBmT3a+ahUV9ls3sql65cWvlA9MzwCFjqQFqbSWYmX+djSY6/
	 ucuJ1YYQN/ZXsOPhL62qNPiahE5NFPTdgJCFMun3A9Vu0aE/PTmijwElLhkVammbWAmAV
	 khl5GppNvaoCm6TQCz5jRtGUIo1pSsN0KAh5O1yR2wZWjrLAZDQv204cpQcrBDYZerFfS
	 0wS3+kBmzMAIkqnYD65VuQ0cZP0V0KgEqzzg8vBLxtt8LQ9qCrcSCyOozDtqE9ZqfX7DS
	 hXeuATX8/F4E8vDHhJU9N6tBA74Enj9n+OFZN5pdCrWrEF9Coj2KZcnwq/VyUxw+/Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F30Xv+mS;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2DD606A327
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 19:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E2DD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F30Xv+mS
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-497614c95f0so636750f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794599099; x=1795203899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TSQaVzf8K6j4RVfK5HDz3FjLKLxGcucq+FqTpajAUEk=;
        b=F30Xv+mS4lS0O8CpXMoXKeLA6GLKhjJmrWtumTTHsFSFRx5uuE3LGWPibDRVHegjho
         YtR5Pwn95fi02QbWg7Q3lDLTOQ9yO348o4sBjZOu1RdJRS645jcczHhDF4Ob9P7ptWli
         AoOOCoB5EI+pMpioc7P8RDlf7FyuvWnrsNn7uWId+7Wl+8F0mV1S0w+p/qT/DjXeaAjv
         aO+lQ+rtwcWYTv31g6g8qLUdFXBIZB3kYyN4tkm5NOJjnM3KSTF3lLfxEMO/zSB4PbYB
         v8k8eIwbdGAw2nXgM7Zy9nfrKPZCdsJWydnZf3KgSlo0ySEIDDXJzp6bWbgmDL7Ixqfx
         25AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599099; x=1795203899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TSQaVzf8K6j4RVfK5HDz3FjLKLxGcucq+FqTpajAUEk=;
        b=cEFs8x63iBjmVENWgs0Q3onhAg2knztkytxkHXvBwXHfhuy/JIQBSaSZqjHtvHPAQV
         NfgXpmq61F00+Mby8T3nuA71Sl5LKTwHcxia1ezaZxWFBdUFiXyNM/938PO2EWVaJDa1
         U5p8cEIFfOShlZgmH/jvD/IItHgenXrj746I0MdKsLM+btXhXt0kRm76mhbQ5DCf2arO
         eHcf23XzIJ5tDmoAJmU0phCTWaBDMhdWYVWIilVx51t0GwFj8vod/RsZz5rqLXCxmyaG
         /cI8M2gDAnz5SyM+SLTGCj8Dz8+eH/xIjLqWg+ucloGprL6yIJ/iqWYAoQveIfVrGeuG
         erTg==
X-Forwarded-Encrypted: i=1; AL+hErFmYenwfRRB1TKUZdBA/Mf78cMYK2JRV4nnm+je6c9aTxtMHdExSr89sFTLlpMinbDojW+kZlNNo9H5we94XXQgXER2Om8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SqAZXgkEe/ob7HX2SFL3nZ+NI62cLnDBT/qMH+I+Xb3KZMU7w
	9PCoKHJWN3vEvuw/AKLgnEFi4sMTUQnvlRhm60TBXH+P5pJS4zQUG/aP
X-Gm-Gg: AYBFou3WYOMSKUwz/O1HxlB6nBJeUFASsiH1mVhm6ZlbWMeUwiWJp6hW1Y4GTtq97Pe
	rDA40Sqpz229XlaAY+gYhlmBB/lPqFsL5cosJi57WUlmbVwi0uvWB3mOltEoQBPqaLp+oRS59oe
	tVLZqby/rxgooJv5nBjvIGA8Gv/I2s/krSY36bqJt3bLmpRyJdPjMXIwFlVtiGpVDdaLpTtkJY7
	J1wJ8zWix6JB1snxvwCX3mkh7MMU9PjnOEKQJDWhy76KyCl/tTJZtoxVu7WA5RucoU9/vZXKgp0
	6qMdo7KqgdYkrG5rQJrZ0a2e3RnAvijyR1ep9tJLy7//D+HmN1Hp7jaUsvvvSZjOrceC1Q6/0aU
	iV4oRVxTDNpb7kUAsruX+8ArTXPjxDbJPU8E3augTexNP+hMXe4bD9xBVTbu7d48PcmOjfw1jw5
	/cttbb/bHKUeLKpzPM26jZAGaC8L8Qs9AuKNw1A7UZZqK5aqoKB6AKNLR0SbpthzFbFV6PyAFXS
	VMXjwGP9VldPSsWTDOaFf7O3yunYcguPvzp4n9EhPfUwCAPEcS+5JvwNOVA5b3uCXPcBV/WO8pC
	d6ndNCx+8F25go6lY2RMXX2HbbyPA0vI51XpbU2C/iosn+vRkhWGYA==
X-Received: by 2002:a5d:5c03:0:b0:492:9630:6a71 with SMTP id ffacd0b85a97d-49c6fc9dbe9mr8723383f8f.1.1794599098394;
        Fri, 13 Nov 2026 11:44:58 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c69406640sm6647059f8f.12.2026.11.13.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:44:57 -0800 (PST)
Date: Fri, 13 Nov 2026 20:44:44 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] landlock: Simplify landlock_get_fs_access_mask()
Message-ID: <20261113.a18c311fd502@gnoack.org>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-3-2b405fc1b3aa@gmail.com>
 <20261113.ojir0eich9Ja@digikod.net>
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
In-Reply-To: <20261113.ojir0eich9Ja@digikod.net>

On Fri, Nov 13, 2026 at 12:25:36AM +0100, Mickaël Salaün wrote:
> On Sun, Nov 08, 2026 at 09:23:50PM +0100, Günther Noack wrote:
> > Return the handled FS access mask as it is, instead of artificially
> > adding LANDLOCK_ACCESS_FS_REFER to it.
> > 
> > Since commit d6c7cf84a24f ("landlock: Simplify initially denied access
> > rights"), the merge operation already bakes the initially denied
> > access rights (LANDLOCK_ACCESS_FS_REFER) into the a layer's handled FS
> > access rights. -- They don't need to be added explicitly any more.
> > 
> > No functional change.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  security/landlock/domain.h | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> > index d9ebf4857fce..812c324cb6ef 100644
> > --- a/security/landlock/domain.h
> > +++ b/security/landlock/domain.h
> > @@ -262,16 +262,12 @@ static inline access_mask_t
> >  landlock_get_fs_access_mask(const struct landlock_domain *const domain,
> >  			    const u16 layer_level)
> >  {
> > -	access_mask_t handled = domain->layers[layer_level].handled.fs;
> > -
> >  	/*
> > -	 * Handles all initially denied by default access rights, but only for
> > -	 * layers handling filesystem accesses.
> > +	 * Initially denied by default access rights are already included for
> > +	 * layers handling filesystem accesses, see
> > +	 * landlock_upgrade_handled_layer_config().
> >  	 */
> > -	if (handled)
> > -		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> > -
> > -	return handled;
> > +	return domain->layers[layer_level].handled.fs;
> 
> Could we add a small companion KUnit test to make sure the semantic
> doesn't change?

Sounds good, I'll add one.

I'm running under the assumption that what you mean here is a test
that covers both the upgrade function and
landlock_get_fs_access_mask(), so that that KUnit test keeps working
in both versions of the change.  I'll stack it as a separate commit
after the first of the two changes to landlock_get_fs_access_mask().

–Günther
