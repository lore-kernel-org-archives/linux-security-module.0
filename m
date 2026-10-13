Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5F4B8262
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910479; cv=none; b=Bitylxhix3evZ0Y1JdyqJAlV9FJobfIXTW6xQWmalYbP+HH9wW2P+jG50zF4JrbdHxY5zPMv/YdKZTygd5ZnOlU7cwVJZegQ27z4c6fWpDCYKm94pQD4nLMBwzOpHvmA9D8Hl2ezeBLdWq7S+V0lPMBsrW5Tp8D1LnTbi5mndos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910479; c=relaxed/simple;
	bh=JHQcwO9QiD+lGa8VckYlb04zBiyisV18fct2USXZsfM=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r7kTBtx/1/OFrk7fFgHfiOTQ7BTIyiaDCUxsehVd9nwbsEiQuqjyt5WNRVHR5M0dsTGGO1YmT2dp8GwlH94p9kc52qTOXIe1gQqTULEocIzi5iKUq9a1+iIC8DaUN97cU2aU7B0ffd+pRUx4RqNCRh/LXyNcJkqejxhnEZkftPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/kCBsrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/kCBsrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94BD1F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910477;
	bh=WGKguqJIivFmEONvKsztHZTNREc7LtEva1tql615yf4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=A/kCBsrYoWN/rScS/OXToRla9UTN68XLohztm46thj0btW/xxRQyPwYJiPLjWcRhv
	 glqitmhYAhunez7MSSk/8XW4fXlPT61WFsIWDE9jsq7q28JXXn8YWVSkF/M8IUCdb/
	 WxwFsQrTkp3r1bhu/cdIEQCekReE96UoE+ODqSxRL7Ih/e4tUquWkig49qSx+n7BSu
	 VB5D2/ZfvpkUwhgBaFATp7z2RJ9Wa4E8sBc6ooAcdus29zFz8UlJB78eg81PCO5W62
	 KW5Y3LTYCzIt3s6aH1uWnsUMu0C3hbaiULnWGKLEG55B0TKLdzPUA8PwSdb2xA7n5n
	 hkBFtgCRpIxmg==
Message-ID: <sashiko-outbox-170169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 04/11] namei: expose the stepwise ancestor
 walk to fs/
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-5-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-5-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:54:37 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Make vfs_walk_start(), vfs_walk_next() and vfs_walk_end() non-static
> and declare them in fs/internal.h next to the walk state, so an
> iterating consumer (BPF) can drive the walk with every step and
> invariant staying in namei.c.  vfs_walk_ancestors() and its callback
> contract are unchanged.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D4

