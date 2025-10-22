Received: from mail.taskera.pl (mail.taskera.pl [51.75.73.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD97301472
	for <linux-security-module@vger.kernel.org>; Wed, 22 Oct 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.73.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120698; cv=none; b=aMC4FaUlng93QbRRVrmAGdzbmaW/ZXPzE2seb7ZG92kjILCCGCxWIbsG8gcNJZb0d7UshnUCvihsTiUUZKAZmmYaNgGkq6Jr/nbFo4vEWKAWjy2+TC88NHskJv78WvhlhUGUMHiSgOj/9WIgiypyfeIDgmRWjbsLRCZYkVrhl4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120698; c=relaxed/simple;
	bh=LHmroAf0IX0JOjVUiIwqM4s8ghVxxktECxT6AQD+q2c=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=JN2ukOniWCU1CMQUgc0/oBSUeddGnLjdJ/rz4fqSlMHY53+u4tVvq7P6GFwIIXiIHvD35yPiFlhYtmnxljCnZ2aFClfIyT5dk6O1WtlZ+XMYPsgAgRQHtdPaT6hlrolIy50ZkBZthF344oYDE5tV27dd4j+CtIgWgbyJ2tcgAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=taskera.pl; spf=pass smtp.mailfrom=taskera.pl; dkim=pass (2048-bit key) header.d=taskera.pl header.i=@taskera.pl header.b=FvriWvvv; arc=none smtp.client-ip=51.75.73.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=taskera.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taskera.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taskera.pl header.i=@taskera.pl header.b="FvriWvvv"
Received: by mail.taskera.pl (Postfix, from userid 1002)
	id 6EDCE25CD2; Wed, 22 Oct 2025 10:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taskera.pl; s=mail;
	t=1761120694; bh=LHmroAf0IX0JOjVUiIwqM4s8ghVxxktECxT6AQD+q2c=;
	h=Date:From:To:Subject:From;
	b=FvriWvvvODAGPYwQGyOGQ8UkhNRiUJ9NZ5Q2RAk1mRjtIN1KK6ayh2AxrJeMB4/al
	 9jEDSP/i0OSgDoZt/EZDPFoHFM2omeDMX+W+BaBeNvDk1tPoKf7TG+Mt0oBBpju8w6
	 U3gbphVrTRw72hJkXi1jO2v9H3RM30JUPtGzWxjtGTfvQtk71zxe8rHFtA8MDpZsh6
	 Na9hFn5J4nLO9TIwUeIzMjiKw+dj99NlUlHxzW/YFhKOOgAzG3mu4ydcdNXaCb58xy
	 i7UjyiTZq2WfQ3JkaBu7L8OTRQ82LC05HaqTZ7gkaEsUYQCUQ3laljaOyH0g/wES3h
	 1Ak152hggBlrg==
Received: by mail.taskera.pl for <linux-security-module@vger.kernel.org>; Wed, 22 Oct 2025 08:11:10 GMT
Message-ID: <20251022084500-0.1.e0.vvd9.0.14a2ko8i22@taskera.pl>
Date: Wed, 22 Oct 2025 08:11:10 GMT
From: "Eryk Wawrzyn" <eryk.wawrzyn@taskera.pl>
To: <linux-security-module@vger.kernel.org>
Subject: Zwrot
X-Mailer: mail.taskera.pl
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

kontaktuj=C4=99 si=C4=99 w imieniu kancelarii specjalizuj=C4=85cej si=C4=99=
 w zarz=C4=85dzaniu wierzytelno=C5=9Bciami.

Od lat wspieramy firmy w odzyskiwaniu nale=C5=BCno=C5=9Bci. Prowadzimy ko=
mpleksow=C4=85 obs=C5=82ug=C4=99 na etapach: przeds=C4=85dowym, s=C4=85do=
wym i egzekucyjnym, dostosowuj=C4=85c dzia=C5=82ania do bran=C5=BCy Klien=
ta.

Kiedy mo=C5=BCemy porozmawia=C4=87?


Pozdrawiam
Eryk Wawrzyn
