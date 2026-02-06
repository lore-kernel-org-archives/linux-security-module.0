Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674819CD1B
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770377059; cv=none; b=PRazq/ZXVW1pgscpB1FGPVbRxwVZEop2Fx2kl/JNBrtkZy391+40HJDVH7QBVq+3ZrXw39zJ4h1823MItFuTQ+ElDbCGobneculzeMDLt7LfCzW1T7eh5Zn9OTu4Qd8dh4bT/K3B1vz9EHDE5DbhwGg+H8RBK1XXx1dJihs9bJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770377059; c=relaxed/simple;
	bh=JY2AwxryEGd/U9OVuc6VsRChvE/nzt9LT9i0ZhZSHeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbPWsex9eCb8BA2xGStX7ApUZ6hoX6/wnovl1izo/rd+EJ8e0EcQJLlG62eViNEH+yMyUXJQE/LUulxvT5ws/up65cr1vOwNPHst43eatJ/8hgRZ/lpf8btL2TYNuoPOCrywEQPZj7nwxeKMec3BAD/I7QVZRxJ5oAKKmCBN7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OT+AVdCF; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OT+AVdCF"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f6sDV43wQzjZx;
	Fri,  6 Feb 2026 12:24:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770377050;
	bh=P3LKOorLE6x+2arn4OCzcEUVXskV+Hg2eU1/uNtg/n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OT+AVdCFpKXD8uVpiwMPEtKz1vxLjq7gEf726g+W/Zb9oaAIYaBfc0uG3OV7SQZb0
	 Aya+rFSvct4Qx+j/VvKw8ZymUVy7u2F/spOLdP3HqLOmkk1vzk47tp21lbB8aJngPw
	 949uVPfZFVTDY7UbDvpf6r0Al6O+9QbgAEfPZd6Q=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f6sDT06L0zG7t;
	Fri,  6 Feb 2026 12:24:08 +0100 (CET)
Date: Fri, 6 Feb 2026 12:24:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/3] landlock: Refactor layer masks
Message-ID: <20260206.OoguTe7ha9so@digikod.net>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260128.jiethoh2Zeem@digikod.net>
 <20260206.9509420815f5@gnoack.org>
 <20260206.a8bf33606ef0@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206.a8bf33606ef0@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Feb 06, 2026 at 08:49:39AM +0100, Günther Noack wrote:
> On Fri, Feb 06, 2026 at 08:32:06AM +0100, Günther Noack wrote:
> > On Wed, Jan 28, 2026 at 10:31:07PM +0100, Mickaël Salaün wrote:
> > > On Sun, Jan 25, 2026 at 08:58:50PM +0100, Günther Noack wrote:
> > > > P.S.: I am open to suggestions on what the "layer masks" variables
> > > > should be called, because the name "layer masks" might be less
> > > > appropriate after this change.  I have not fixed up the name
> > > > everywhere because fixing up the code took priority for now.
> > > 
> > > Could you please clarify your thoughts and explain why this name might
> > > not be appropriate anymore?  Any list of name proposals?
> > > 
> > > If we rename the variables, this should be done in the same refactoring
> > > patch.
> > 
> > When this was an array of layer_mask_t, the name layer_masks was a
> > description of that underlying data type.  Now that we have removed
> > the layer_mask_t datatype, it is not as obviously true any more.
> > 
> > When trying to name these variables after the "role" that they have in
> > their declaration context, I think of them as "unfulfilled per-layer
> > access requests", but that strikes me as a bit long.
> > 
> > For the upcoming patch set, I'm leaning towards naming these variables
> > just "masks", to keep it short.
> 
> OK, staring at the code a bit longer, I realize that since the type is
> now named "struct layer_access_masks", "layer_masks" is actually still
> a reasonable shorthand.  I have abbreviated that to "masks" in some
> places where it is anyway clear from the context that those are the
> layer access masks, but left it as "layer_masks" in places where we
> also use other access masks, for disambiguation.

Looks good
