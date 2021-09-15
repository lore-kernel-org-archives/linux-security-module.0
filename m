Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D98C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Sep 2021 12:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F50610E9
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Sep 2021 12:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhIOMf7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233051AbhIOMf7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Sep 2021 08:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631709280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAHaD1xQo/44CTGn6NeEOEBL1rB3vK5Y9WJiyRltNw0=;
        b=Pc31ucIHpdDB05rD67UDUFAbVejYgVAX6kclYJat38d1jSc0lJkxMZEWmb8GEQldjsS12A
        FqLprg2QdNS70DALBBIt7LP9USjzJIPzOdRyqPuRkXXcL8rpbiUxRXFhHfTEMogpDukXF/
        ogVl3iADOG7AEypVevbbGJQxKSBjSI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-T6v-5GzXPLC97wCNZtASTw-1; Wed, 15 Sep 2021 08:34:37 -0400
X-MC-Unique: T6v-5GzXPLC97wCNZtASTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8DE1101AFA7;
        Wed, 15 Sep 2021 12:34:35 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50254100164C;
        Wed, 15 Sep 2021 12:34:27 +0000 (UTC)
Date:   Wed, 15 Sep 2021 08:34:24 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com
Subject: Re: [PATCH] lsm_audit: avoid overloading the "key" audit field
Message-ID: <20210915123424.GN490529@madcap2.tricolour.ca>
References: <20210914131516.128823-1-omosnace@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210914131516.128823-1-omosnace@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rgb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021-09-14 15:15, Ondrej Mosnacek wrote:
> The "key" field is used to associate records with the rule that
> triggered them, os it's not a good idea to overload it with an
> additional IPC key semantic. Moreover, as the classic "key" field is a
> text field, while the IPC key is numeric, AVC records containing the IPC
> key info actually confuse audit userspace, which tries to interpret the
> number as a hex-encoded string, thus showing garbage for example in the
> ausearch "interpret" output mode.
> 
> Hence, change it to "ipc_key" to fix both issues and also make the
> meaning of this field more clear.

Good call.

> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  security/lsm_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 5a5016ef43b0..1897cbf6fc69 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -224,7 +224,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>  	case LSM_AUDIT_DATA_NONE:
>  		return;
>  	case LSM_AUDIT_DATA_IPC:
> -		audit_log_format(ab, " key=%d ", a->u.ipc_id);
> +		audit_log_format(ab, " ipc_key=%d ", a->u.ipc_id);
>  		break;
>  	case LSM_AUDIT_DATA_CAP:
>  		audit_log_format(ab, " capability=%d ", a->u.cap);
> -- 
> 2.31.1
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

