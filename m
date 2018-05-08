From: john.johansen@canonical.com (John Johansen)
Date: Tue, 8 May 2018 10:49:16 -0700
Subject: [bug report] apparmor: add support for mapping secids and using
	secctxes
In-Reply-To: <20180508093901.GA3155@mwanda>
References: <20180508093901.GA3155@mwanda>
Message-ID: <2a52cd12-5f70-6bac-0a9b-ba695070586d@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/08/2018 02:39 AM, Dan Carpenter wrote:
> Hello John Johansen,
> 
> The patch c092921219d2: "apparmor: add support for mapping secids and
> using secctxes" from Jul 31, 2017, leads to the following static
> checker warning:
> 
> 	security/apparmor/secid.c:162 apparmor_secid_to_secctx()
> 	warn: unsigned '*seclen' is never less than zero.
> 
> security/apparmor/secid.c
>    141  int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>    142  {
>    143          /* TODO: cache secctx and ref count so we don't have to recreate */
>    144          struct aa_label *label = aa_secid_to_label(secid);
>    145  
>    146          AA_BUG(!secdata);
>    147          AA_BUG(!seclen);
>    148  
>    149          if (!label)
>    150                  return -EINVAL;
>    151  
>    152          if (secdata)
>    153                  *seclen = aa_label_asxprint(secdata, root_ns, label,
>                                   ^^^^^^^^^^^^^^^^^
> This can return -ENOMEM on error.
> 
>    154                                              FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
>    155                                              FLAG_HIDDEN_UNCONFINED |
>    156                                              FLAG_ABS_ROOT, GFP_ATOMIC);
>    157          else
>    158                  *seclen = aa_label_snxprint(NULL, 0, root_ns, label,
>    159                                              FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
>    160                                              FLAG_HIDDEN_UNCONFINED |
>    161                                              FLAG_ABS_ROOT);
>    162          if (*seclen < 0)
>                     ^^^^^^^^^^^
> It's strange that this warning is only showing up now...
> 
>    163                  return -ENOMEM;
>    164  
>    165          return 0;
>    166  }
> 
> regards,
> dan carpenter
> 

yep sorry the kbuildbot reported this to me back on the 4th and for some reason (probably
distracted) the fix didn't get pushed. It should be there now

thanks


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
