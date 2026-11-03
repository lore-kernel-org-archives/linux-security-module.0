Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714432;
	b=NNj28Z6olXCU/W7urttgGS5Or3WZylOcuXUWErW1pDBjntHN5zQk8kLkC/GVGvVgryfA
	 MiMxdAfDsgsMwMigUEwBYZi1wgtwUb7i3JG6yu5bzOSjtoiDk4uGID0AmJiO3CB01vcrL
	 N+UTjTWbuiwxtqiWdqbEmJx2QjvBDVwedRVEhF0u3E98CJ+o5tAGTIT5j5O/Uod/gRA6e
	 hIO26i7qhPasI8AqXY4lEaMHDc1qbgaRiKdU+TqO5IRVbUZ5TMTaDxNkylLJdfH8WZIs2
	 gPUfWe65tkl+uHTFPso9ntrsLb3HWq1znNE1Ij7ul9m+ZhxJUVzjEmg4IHjPBu9awoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714432;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID:
	 Content-Transfer-Encoding;
	bh=AcmgtxFJR0nhW+eGy4hzW0AzJEZZC2gd3/6jDkGo1tI=;
	b=1sya7VRpUeWVZe8jl5Fq3/HmK/hN5S+Y0rBOrSQtXz+MHzL89qYvnDklKQUmR1XCJZ5Y
	 etQ2836n+crI6LAoRpSfXm/XOzIna3XfFyPFgWkJ5hExfezHIzlhVZsv+FHudDdzcUEn/
	 ujAzOw6W8umiMUVz281VVrymUJBDqEOxlbbrEqzmByftSkKMJxtNRxIcL4QlmoP0TxEPG
	 0yfuqjigY3J4RgJaijr/+rMR4Iysh4j15//ynyH2f7SlGzBcB7VCQSsWNzFfxHsa+tXjv
	 ZR7yjnOsDgUQs6ghcex+lSNdl4KpPUCL7dUXI4hFIzC0K6Qa5DknSqf38ScZsXHZZXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IrfhA2Mp;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73B606A333
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 14:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C73B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IrfhA2Mp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793714431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcmgtxFJR0nhW+eGy4hzW0AzJEZZC2gd3/6jDkGo1tI=;
	b=IrfhA2MpFQueGJqgBOz5+EwSk8BJ0nDAZ4LWNbLS0Wi41ZSmyTK7W/DGqPbVvJFeMzY0r+
	yQU1tYzLm3lqNFxE95azVLw4Bdkd9tGS1OBWsn9HlPQImJ5ReCfK55/7iOIbuyxkWGERmR
	tP1mDf4iThhWL+TZgGPeFCzZRE8ayDk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-rJvXjCVzOPOFfXzcTVxD9w-1; Tue,
 03 Nov 2026 09:00:28 -0500
X-MC-Unique: rJvXjCVzOPOFfXzcTVxD9w-1
X-Mimecast-MFC-AGG-ID: rJvXjCVzOPOFfXzcTVxD9w_1793714424
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E98C018007F1;
	Tue,  3 Nov 2026 14:00:23 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 931947EB;
	Tue,  3 Nov 2026 14:00:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aunNj35KmcAC4ByH@kernel.org>
References: <aunNj35KmcAC4ByH@kernel.org> <20261103030226.2685251-1-jarkko@kernel.org> <641294.1793700187@dhowells-thinkpadp1gen8.rmtgb.csb>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
    keyrings@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
    Eric Snowberg <eric.snowberg@oracle.com>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
    open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] KEYS: Sanitize the garbage collector
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 14:00:19 +0000
Message-ID: <669211.1793714419@dhowells-thinkpadp1gen8.rmtgb.csb>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: SZMYVqjaiFULrUf0zlIigBZub8M5irdp3lN7NsZs-qc_1793714424
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <669210.1793714419.1@dhowells-thinkpadp1gen8.rmtgb.csb>
Content-Transfer-Encoding: quoted-printable

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> > Please don't do that.  That will cause the AF_RXRPC module to get pinne=
d in
> > place by outstanding connections that haven't timed out yet.

Actually, it can be done if the rxrpc and rxrpc_s key types are moved out i=
nto
their own module upon which rxrpc.ko depends.

David

