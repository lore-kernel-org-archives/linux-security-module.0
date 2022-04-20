Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D4DC433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Apr 2022 10:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbiDTKcB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiDTKcA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Apr 2022 06:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 141383F887
        for <linux-security-module@vger.kernel.org>; Wed, 20 Apr 2022 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650450554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIJu0PnDJV4/uO0UdPgu/58WGciQu1suUPJ1SFUvK60=;
        b=G5i088Diuaz/Oj1WT128VTenOepL4bHwwY8o5EBnLJpBpO6qQnFEDGqmF0rUP5U2G5zoCI
        zw6x9jAbE1DXzGdTUy9ZwNMp0M25r4bsSYA5uqNjQYFApmo9vfWXA0TnZNj9Lw/VSsnzzE
        8EsOxGDsQi9h0r8sf8+TxrM+dDcxST0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-5Q0XG3XRM2uJXHWtLXv0tg-1; Wed, 20 Apr 2022 06:29:12 -0400
X-MC-Unique: 5Q0XG3XRM2uJXHWtLXv0tg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83F2338149C1;
        Wed, 20 Apr 2022 10:29:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E39654022C4;
        Wed, 20 Apr 2022 10:29:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210312171232.2681989-4-mic@digikod.net>
References: <20210312171232.2681989-4-mic@digikod.net> <20210312171232.2681989-1-mic@digikod.net>
To:     =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMicka=3DC3=3DABl=3D20Sala=3DC3=3DBCn=3F?=
         =?us-ascii?Q?=3D?= <mic@digikod.net>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMicka=3DC3=3DABl?=
         =?us-ascii?Q?=3D20Sala=3DC3=3DBCn=3F=3D?= 
        <mic@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 3/5] certs: Make blacklist_vet_description() more strict
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 20 Apr 2022 11:29:08 +0100
Message-ID: <648218.1650450548@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> +	/* The following algorithm only works if prefix lengths match. */
> +	BUILD_BUG_ON(sizeof(tbs_prefix) !=3D sizeof(bin_prefix));
> +	prefix_len =3D sizeof(tbs_prefix) - 1;
> +	for (i =3D 0; *desc; desc++, i++) {
> +		if (*desc =3D=3D ':') {
> +			if (tbs_step =3D=3D prefix_len)
> +				goto found_colon;
> +			if (bin_step =3D=3D prefix_len)
> +				goto found_colon;
> +			return -EINVAL;
> +		}
> +		if (i >=3D prefix_len)
> +			return -EINVAL;
> +		if (*desc =3D=3D tbs_prefix[i])
> +			tbs_step++;
> +		if (*desc =3D=3D bin_prefix[i])
> +			bin_step++;
> +	}

I wonder if:

	static const char tbs_prefix[] =3D "tbs:";
	static const char bin_prefix[] =3D "bin:";

	if (strncmp(desc, tbs_prefix, sizeof(tbs_prefix) - 1) =3D=3D 0 ||
	    strncmp(desc, bin_prefix, sizeof(bin_prefix) - 1) =3D=3D 0)
		goto found_colon;

might be better.

David

