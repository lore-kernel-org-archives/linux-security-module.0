Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB31E1024
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996248; cv=none; b=plkcSi6ov0I5jP/jACxc/DZhMgc7SxRwTkBLHbsRIrhPBLjrNvJN3VB9M4JU5NcsyIng8Qmt7MTwfbBTgnkJ9oXiGkFK4yqIs35KmgFpOJXmYIKzaLYgPAAMVx6KLgnJ92UvkKHVOowJUHBRjJUPj+m+w339K6GmrHM3hrrRJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996248; c=relaxed/simple;
	bh=6mLmGwqOupZYhPYqC/ZjlynhA2Eey/qRFDAQ4c2jeeo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AZC9M6wzaKQh4N7UcE64dudqJxqxKaDlcs11TA8oSIeRXSuFfDanNZGYJG2Ooe4Vs4umW9OIKweU1OrQq8QLEvCp8YKwEX/sI3upoWGeycMOUM4qIyePZgfXrjbwVBp0OFkdbYAKHfKQ69PF5et5X0K8uLJb6CBIhe7Vu5gZwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9HfV+sZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9HfV+sZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1600B1F000FF
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996245;
	bh=6mLmGwqOupZYhPYqC/ZjlynhA2Eey/qRFDAQ4c2jeeo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=l9HfV+sZ5cLCi3K3QHymwBkjIFndN6lnjcmXhCnUU5OkCJ4QDDlffCLttnMGW15rn
	 VKNPaDJk4VSaPJR+/rdwzsf6L4CdMEgqI3pUAz8WIfJ2A+M+e8dGMWzTt45r6Nuu5z
	 iCLWeCPXo2eSq7Kp8PMXwGuRkqkZzMA4MFMnMsJyp+KzGjQr+2clklo6g4I/iXnayU
	 vIjwGFFl7ZXGxK7pFQjHefrUiDh8bGjwBOZu8srbN0A2VD6NW2o33WHHpKkiRWcI2h
	 kNvNRrnZgw829SR6C1XFZ6oZA/SbXY7CR/5zzsf4tEobHrX135N9hKJiEEb1mhlXQ+
	 yfdu/OzoFH4dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] ipe: correct policy text ownership comment
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261003025135.3666767-5-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
 <20261003025135.3666767-5-wufan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:57:24 +0000
Message-Id: <20261003025725.1600B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Policy text is separately allocated only when p->pkcs7 is NULL.
> Correct the comment to match the existing free logic.
>=20
> No functional changes.
>=20
> Assisted-by: LLM
> Signed-off-by: Fan Wu <wufan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003025135.3666=
767-1-wufan@kernel.org?part=3D4

