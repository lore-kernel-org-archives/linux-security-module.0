From: paul@paul-moore.com (Paul Moore)
Date: Sat, 11 Nov 2017 10:48:29 -0500
Subject: [PATCH 0/9] LSM: Stacking for major security modules - Based on
	4.14-rc2
In-Reply-To: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
References: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
Message-ID: <CAHC9VhQ+BBoxz7cTnTc46hQ88LnLM72fNA9zhDbWn8XUoVS1NQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Oct 27, 2017 at 5:34 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Subject: [PATCH 0/9] LSM: Stacking for major security modules - Based on 4.14-rc2
>
> This patch set implements stacking for "major" security modules.

...

> I have tested these patches in various configurations of Ubuntu and
> Fedora. Smack and SELinux together pass test suites with some exceptions.
> There are conflicts with the way the modules treat network configurations.
> These conflicts are under investigation, and changes to Smack (and
> possibly SELinux) to reconcile the worst of the issues are in development.

This remains my big concern, especially the network support.  We've
talked about this a lot in person, but until I see the code which
deals with this I can't ack/nack this patchset.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
