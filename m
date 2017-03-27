From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 27 Mar 2017 08:24:36 +0200
Subject: selinux: Delete unnecessary variable assignments in
	policydb_index()
In-Reply-To: <CAHC9VhRHEDCRNVfOqw4mwJQD9PmESEcgyZ7xCEwHZKpiDSjnYw@mail.gmail.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<247c0e27-c442-3408-4f92-492629d61fbf@users.sourceforge.net>
	<CAHC9VhRHEDCRNVfOqw4mwJQD9PmESEcgyZ7xCEwHZKpiDSjnYw@mail.gmail.com>
Message-ID: <1ae9af46-a3ca-33b8-d347-8983a22cb3cb@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> However, I agree with Casey that this patch is mostly just code churn
> so I'm going to drop this from your series.

How do you think about to return only constant error codes in this function?
Would it be acceptable to replace any statements ?goto out;? with
?return -ENOMEM;? here instead?

Regards,
Markus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
