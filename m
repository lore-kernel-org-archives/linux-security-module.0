Received: from mail.novencio.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDC3314CC
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542923; cv=none; b=moCiOba3raf+6URK5rTydJWjyGAfEYYesnpM7/IZmZkUlZYPOhB5lcYT0FV2AskK1M4dNSbaBMHr6Qcj8MaJ1u7KJazgZHCY3n9hGAVKTcbj5UGMDOZYdwR+hHsFIlKWapnCU4saHvJWO/TqjF6zOw3qKtS8wjOLQWNL6w2duwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542923; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=lBsw/VcICB6SNk2HDrLWiTirxYBgGvfBkrwmGyH98rfVW2DSxsZwFedPNt2s7fEEbvcpOcDLHM00IGRn8xoWrhRdGmfIUbcuHPqVa77GAcajAhA/IiuKx8PPOp3eNs9UIY3GUwz5Bcy0+IeA90k3U+p23xBxpijpM46GVBs3X4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b=QSptemfj; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b="QSptemfj"
Received: by mail.novencio.pl (Postfix, from userid 1002)
	id B50DB24DFA; Wed, 19 Nov 2025 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novencio.pl; s=mail;
	t=1763542919; bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Date:From:To:Subject:From;
	b=QSptemfjLdgWYxTiNa7Fgr2irOJ5LqeFnUFqLzaRy8BvIxXJV4aKsgFK9kqybQuNH
	 UsMZMX81OBbSFRqtsPsXe3nvzMk4ldM4JqMafSOouQuaGX10mTVLsDSX0DoFZwqgtk
	 5ptpU/xVUTyEDaDJHVcqaz90BfNL6vl+UkYhgwTGS9TMiL/mteKrLlE1Mxb6uSqM3U
	 dXQ0F0OQa3yf3ggMzjaOXvbLS+YeaPD/iJkGWGlhTu4L+9Hm3D6WOcYxGGAgxqhuMr
	 hZd1jTw11CO/V9S/OiMBdi3MWRvili/H+/A/TzgDHOsXyNGOSxZzEMZyLfCodZNuK9
	 RwoEs7mXuruew==
Received: by mail.novencio.pl for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 09:01:03 GMT
Message-ID: <20251119074742-0.1.5y.z4hc.0.1c6j8jk4pd@novencio.pl>
Date: Wed, 19 Nov 2025 09:01:03 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <linux-security-module@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki
