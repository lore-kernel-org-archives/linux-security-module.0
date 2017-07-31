From: john.johansen@canonical.com (John Johansen)
Date: Mon, 31 Jul 2017 13:11:37 -0700
Subject: security/apparmor/label.c:1498]: (style) Redundant condition
In-Reply-To: <AM4PR08MB1156D3B9C875A7F269BAC8E09CA00@AM4PR08MB1156.eurprd08.prod.outlook.com>
References: <AM4PR08MB1156D3B9C875A7F269BAC8E09CA00@AM4PR08MB1156.eurprd08.prod.outlook.com>
Message-ID: <16fc1e64-600e-d1a8-fb59-5910cd3ab92e@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/17/2017 12:34 AM, David Binderman wrote:
> Hello there,
> 
> 
> security/apparmor/label.c:1498]: (style) Redundant condition: prev_ns. '!prev_ns || (prev_ns && *prev_ns!=profile->ns)' is equivalent to '!prev_ns || *prev_ns!=profile->ns'
> 
> Source code is
> 
>     if (view != profile->ns &&
>         (!prev_ns || (prev_ns && *prev_ns != profile->ns))) {
> 

yep, I will add the fix to the next pull request
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
