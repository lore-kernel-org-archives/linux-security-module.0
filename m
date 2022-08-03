Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09254C00140
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Aug 2022 02:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiHCCeG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Aug 2022 22:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiHCCeF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Aug 2022 22:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D145E1EAC0
        for <linux-security-module@vger.kernel.org>; Tue,  2 Aug 2022 19:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659494043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfwT9+DKgt5KFT0+SHG/ijwTJyDJ1NCJzxhIr/kPWCA=;
        b=gG65v/hJv/xIbeqAzAlBEZtonlyImCii6i4b7xD/dzDsTL7zkESte96XxQ/vGLujVVSh7F
        42AZZo6AICV//pw1s9qg9ikQwzVjH1YQO+J6Qfz37aa+uuL0zewLZNlCstW4cjq2gLUOJt
        ObcARYsDJDyEzKZQWxf+zPMJNlUMQEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-eDOHdqxQOc2Cl54yr-Jqsg-1; Tue, 02 Aug 2022 22:34:02 -0400
X-MC-Unique: eDOHdqxQOc2Cl54yr-Jqsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A122185A585;
        Wed,  3 Aug 2022 02:34:01 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.32.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0A1990A11;
        Wed,  3 Aug 2022 02:34:00 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, linux-audit@redhat.com
Cc:     John Johansen <john.johansen@canonical.com>,
        SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>
Subject: Re: LSM stacking in next for 6.1?
Date:   Tue, 02 Aug 2022 22:34:00 -0400
Message-ID: <2642904.mvXUDI8C0e@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com> <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tuesday, August 2, 2022 8:56:21 PM EDT Paul Moore wrote:
>  I can tell you that I've never been really excited about the /proc
>  changes, and believe it or not I've been thinking about those a fair
>  amount since James asked me to start maintaining the LSM.

Why do we not have auid and sessionid in /proc/<pid>/status  ?

This has been needed for 10 - 15 years.

-Steve


