Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789653CAE7F
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367912; cv=none; b=MqnrAFFhHT44yh2Sc3yN6ECHMI1M91dGhzHD/XzJF9jqErKRezKYar40HqrFKYjVn7OKeCIST6Omb5nsA5mbKZ9w7ExLNWhMfSBY/bOB13e8gsjhxGFVVht24n2KEJik5IST1I2V6lI2icKILQCbFL5p/EuK1xDD0rIjxBuBCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367912; c=relaxed/simple;
	bh=AIe3GIJgc3KA7H/AwIFgf3HOsnuuETu3c7WaoOs0DpE=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b4WtrkpSqL9tYKTG01zpNP9vmnW6MLvL9DK2LUe6oBVvPtlKvqzcFi/zOqtq810T6t9ixckzmDT2Axhnr0YRWyyiS4N2GDh2JzTXR/sngpgr++JuGvp/z75u3jp2t81Cs+YzG6HqOZ3um5okTL7OfM8kVyZkdQOBPd6QhlkHDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW4n4yto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW4n4yto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEC41F0089C
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791367903;
	bh=3/KGA8bgtALOgM4E/n9IqOhSYVgPbyqFyejOdtQIh2A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=bW4n4ytolDsUiRT70wjBw2EXH+MybEQutbTmfxGTWjVbGPIWdzdo+OdBvVvQAQh2S
	 S9UMU7f0Yvh8/jXWgEdzt7TGprwzuB4FOSEI3XBszQJ3YvjpS+YFyH7FwzPzBzN6da
	 4KERiaxKn/hecWDe/flVth+0kQOrZoreVksrqeInGTseEsdj/Cobz9ShiBKls3CPfw
	 6M8w1C5TDctyPTtaqQUVeN/XSNmol9H0x+eciB4Ewv3zgnEP5tOxQOfvDaRvxQw805
	 XYnzj0G5uSi6VqpQXQh/rZgkjQdu/3zu9yTMYyeppARAKBW1FexCP/Px/OPACFoD9P
	 So55dmmMwttog==
Message-ID: <sashiko-outbox-162845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] samples/landlock: Add capability and namespace
 restriction support
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007100255.1333386-8-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
 <20261007100255.1333386-8-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:11:43 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Extend the sandboxer sample to demonstrate the new Landlock capability
> and namespace restriction features.  LL_CAP takes a colon-delimited list
> of allowed capabilities.  Numeric values are always accepted; when
> libcap development files are available, use cap_from_name(3) to accept
> names too.  Builds without libcap warn when capability settings are
> used.  This keeps the sample buildable without optional development
> files.  LL_NS takes a colon-delimited list of allowed namespace types by
> short name.  Add best-effort degradation for older kernels that predate
> the LANDLOCK_PERMISSION_* features.
>=20
> Allow creating user and UTS namespaces but deny network namespaces, as
> an unprivileged user.  The first command succeeds and sets the hostname
> inside the new UTS namespace; the second is denied because the network
> namespace type is not allowed:
>=20
> [ ... ]
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100255.1333=
386-1-mic@digikod.net?part=3D7

