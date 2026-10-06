Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE354707C;
	Tue,  6 Oct 2026 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246523; cv=none; b=ZxekHuysoJ+fQyjEUq/h28pGIvEgbFr2p8kp6fHrHZuyNbatn5vywyjOssj8PPnvdLSQB9GZH0IIziwwpUDDOrnplyEev/fvCVJ0Jai1xIY46lD/nkkKfbZ0QIdJl1ao2Zk15pfk5BPv+o7TAqpWjWArLC8Zx+yoUkeWrNZp+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246523; c=relaxed/simple;
	bh=sWfn+uzoPvZ3B+B/HkirzDj/FwDCs7ayJW1JF1y0VII=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mdxCY+11WYm+Dh9GE74c27XlV1vmz533Wkae4b+2LLuUsVgnz4aGoz6jgxm1VYHIIo+sbAunPybajNIA7Q8hCFqOyfeGUbQNrwNbF0RCFH6uf/AhuX/vSgWbIoIy2HuAUibdYfDt3FrRuOCIYZ6gYGzmNc/3DGVmd4ZKTGHrNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoXc5TAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoXc5TAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15FB1F000FF;
	Tue,  6 Oct 2026 00:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246521;
	bh=sWfn+uzoPvZ3B+B/HkirzDj/FwDCs7ayJW1JF1y0VII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VoXc5TAzS6rWXzvAIdCfseP+n3ZTlDwLD/yJQfvP6O1v1ZKl1JhKV6D2vJ7LEXFiH
	 VyJIhBrSCKQViP2rLCNB2c97USOg9+4GmDK6StT/4uhxz6EnynpgwBQj4Bj3yfX6nS
	 6sEpEF/CyeSXhgUr7Q44e25OThc1NRIkTohCVTikB57S2DYLD4KPiT9u3WpkavmGH0
	 9/fFSwhPXGSydOboDV4q8fENlQAsESuCGkjIgWpAVSesxTOXfobMKWeeSwyGeKVM2M
	 WZWa1d9ao2fHVO8QbKadJSLC13FPk4YhJ2tY1vX8DCyVHzCTf4TKxdpbWfAfgn976d
	 sTHKjzXqyFjWQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 07/12] selftests/bpf: exercise the path
 ancestor iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261006002020.2890858-8-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-8-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:28:41 +0000
Message-Id: <20261006002841.B15FB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Walk the ancestry of a mkdir's parent directory from a sleepable LSM
> program and check that the iteration reaches the root: the temporary
> directory, its parent and / are visited, and no position comes back
> flagged.
>=20
> Resolve the second position's pathname from the acquired position after
> the step that yielded it has been taken, so that the acquired reference
> is what the sleepable kfunc runs on rather than the walk's.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D7

