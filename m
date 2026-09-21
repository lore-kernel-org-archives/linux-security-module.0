Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28B488D82;
	Mon, 21 Sep 2026 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984543; cv=none; b=rMKwY1ulTsKt4VvFb1t/e/c7sPQ6stMadWFhHrJ+l0WzayUfJKv/3Z1pguUlYicNQy0akbSqJZybmUZRIL7rEwi1BusTCuJ+DF5p1ngBBlYOaXnzUxvPx7+XksFUsL/EaOC0Zr3jfAqSmhP2FLH2lyD6T9oWE3v1ZAyq/rJUP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984543; c=relaxed/simple;
	bh=xitebrgQfozlDHUjXYablNzX+mNod0vAa9HopnAgpPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q5BtFi8bjxnsafjB6pGvjQtcVdrJ6krhXRblvKisDZyPkiNyyTP4UgLfC9SJhlZ6Ao6DJu2fJ1ghJehjxF720pvoIucPy8wLl8RqW3rAGqiJOu5gHbkXDz7A6iSn4GMSaJMBkGNLNjwU/vrqvM01xX40gnZxXklhUF7itwC/Hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTNCHG6m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTNCHG6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8221F000FF;
	Mon, 21 Sep 2026 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984542;
	bh=xc6be+nR8guhM9mpkElQVeqn9+wm4Noot3QSvPE7jPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTNCHG6m0nLf3AhC8O1wWj7+w3hIqI5dpY77gRTHyrJMuLtEw5khAKfnFKXzzavJs
	 WK5SBsQ3AGX6HVV2PCvOudNk/a7umdr+9h0WdcLFkdftGwluOS9fczFZKo/7fA4mg/
	 28mk895lwIE4PQV6PZOykhjtxiyItlTds10DY6V5GAW2ICOnGaYflPyGByufXCkral
	 ZdsJk06ck6Is5kWdRm6uTV49Ky3tMu/vvLAyJN2zjqANVPQFXZgjIdOesprQuT5Hqc
	 +kSeqb9Upl34QkyLvbX8ZQhYoCK35cMhyQqQaVY492PlIgC+KLJgC9qG6lSx0qC9iF
	 SF2xAgVp8Vwdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/15] mm/memory-failure: convert process iterator to
 for_each_process_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921092101.89285-5-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-5-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:55:42 +0000
Message-Id: <20260921095542.8B8221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() loop in mm/memory-failure.c with
> for_each_process_rculock(), which scopes the RCU read lock to the
> loop body via scoped_guard(rcu).
>=20
> In collect_procs_file(), the page_pgoff() call now falls outside the
> RCU read-side critical section.  This is safe because page_pgoff()
> only reads folio->index and does not traverse any RCU-protected
> structures.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D4

