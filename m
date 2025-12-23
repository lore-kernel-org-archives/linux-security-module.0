Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723D258EDE
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525326; cv=none; b=BQ0hHqG/RuqcWr8TD/QcZq+YIScLFIg03MD6GJ+B8ZVxjMQ5f1lGurdZEVUXs3EtLvQ+8YFuG7dE16FQG9tjddbxMcTofLTr4aUoWtq6HD2QZ+y0e+WBcUZ0gjzBzp3DZNbafGuN0tR8CQ6/HeUz4O9zwPiBqiXLM84yh4z3Lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525326; c=relaxed/simple;
	bh=ygD2QC66UYPyXy7/jX/9zh0FfCTFWJDrzmixuCLDisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1v0wbAZlHS9lqQzwpBF6rFnZHclDMyjozPFVflOhRDrR3ug8KAfX1K3zVoPAPXU9NVwSCvgxS0eE+Z3TrzsoiY92NWmDbpbt1Llv+0cBtMtPOJ31PhKU1RRrSh5XVDFAfdLAWlchWFCXlOsszZhN/i8E2jFu0E/FtDlBiE/0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izySisf5; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izySisf5"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b8018eba13cso742719266b.1
        for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 13:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766525323; x=1767130123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JJHajaURf2ChUgh1Oe9r+PgZG2mmPI9gDoag4uUZMP0=;
        b=izySisf58Ww9e3KyMdnPq1ssQj7bclhko7/QmV0h1HaSnpJu/VaCEKgy+4A7wUfTsB
         GycjWRc0PDDndw/yP+Oapo0AVjezRg9bJhp7i3+ZUS+0ZaaPYqeR0P1es69PHbh+lFr3
         LQOr9Ey1ELZLxMfVncf8I4U55n914KhEpCG1Sxyjxji1+iC+wp1OFzmcdvwv84wjGMT5
         xl74f7f8Nvp5Kl2EJm5Qf8gIswGIEvEgpEW8U5gbwTvhmR2KwAzwawE87s50begBTT9s
         x0KxZ02Yzwqbp/LZrWqWYiYd4+xxC6uVa0926USxz97At78WPnH64F9wRPqKwb8YtP7K
         p0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766525323; x=1767130123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJHajaURf2ChUgh1Oe9r+PgZG2mmPI9gDoag4uUZMP0=;
        b=TE7JZiI/JC83V6Hh6PIMSGLtpz9FZW7SL6wrm/xSYK01qyMr/2Mi8QZ/ql0XjxlK3q
         r3hb0Y+trNzzJxgWsFw1q/gEa8ednqqpTx3Vai9eD+L5pFGYXWJij0QWFdKO3Fh76fpL
         r5C1Nxil9TxWIctwiPSCmw0QC79fohCCCQLRZbLvahEkj5aH80iNf7zKiwi3I2gAyDYH
         7/hI43OxzQnvuDkqsEEYDc5HiyQVs2t1EQmzyZwpkgQ5DVpJkOWY6osfn2nGIkr8fWHQ
         lyIHK/aMvfvLw5hNYzyMyHta8jxLELIXufPaMrWqQqJJEwoe8xDxfC081IAmRZFvueVC
         nXFQ==
X-Gm-Message-State: AOJu0Ywco3r63tbzkInTFC0ZI5RI4Kcq0pIAJP6JnSDffllV2aeLF9Te
	n/ypDCYt7ORMJT7tryD6vnIrTfaHplwTa5dgFC5slbpNdfoOP5ZHhJ2UYjp85XjX
X-Gm-Gg: AY/fxX71+PGu5qRepxTlM6WS9cJIAH6kQvJhnEUZBPxUQHZvZPBMlK3f0x07EKZhNS1
	iitUnzTBtzDl0lrG3W13S00ePjQK9LH3uTKoKOjSsYTCBhb3g0Mnwm5xgV/9Akp86cQ/bhXXFnP
	i+D2iK7FsdANO2uDN+ayL9B0NhRrSr448nVMT3sLAA31FmPzCQ/STtXm0NFNUQ9oksjnlp3GcQu
	uNXsJIRfiOriTWULBfisltAprEDCVqnfQyaOK0tm677KUhFcb5gYs1Xjx2BvCMmz3wZaF4RVRYf
	15hOorFMAUfmWzNy23cpo65CNXZsjQbM5JMVdYS0SPhVJxNTadtJ+4UrbAvVdM1eidjdYA48deH
	R638WZVxL37na907FOm8h2ICclYnuUlgjDYTXuQW/x+U0E0cechbP50JFCIeohXqTasC4ZKCCXO
	UAnPuo+CSp78hOJK+dbt3aOaOfJ3dg3/kXqUubHB5jpoBbZ+k=
X-Google-Smtp-Source: AGHT+IH8IQHH9LdFoFuWCmt4dBGjw7BNsm9nctnE9/jAR8N8BRRQ7jZlRS9Yk5NSnyExkZI/fvaMLg==
X-Received: by 2002:a17:907:8dcd:b0:b80:f2e:6e0 with SMTP id a640c23a62f3a-b80371756b6mr1594721866b.35.1766525322934;
        Tue, 23 Dec 2025 13:28:42 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a60569sm1541036566b.4.2025.12.23.13.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:28:42 -0800 (PST)
Date: Tue, 23 Dec 2025 22:28:41 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 2/5] landlock: Improve erratum documentation
Message-ID: <20251223.d9f3db6634e7@gnoack.org>
References: <20251219193855.825889-1-mic@digikod.net>
 <20251219193855.825889-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219193855.825889-2-mic@digikod.net>

On Fri, Dec 19, 2025 at 08:38:48PM +0100, Mickaël Salaün wrote:
> Improve description about scoped signal handling.
> 
> Reported-by: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
