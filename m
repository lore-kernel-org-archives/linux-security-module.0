From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:37:20 -0400
Subject: [PATCH 38/46] selinux: One function call less in five functions
	after null pointer detection
In-Reply-To: <b71e766c-a9a2-cd9c-8f87-7aaeaaf896f0@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<b71e766c-a9a2-cd9c-8f87-7aaeaaf896f0@users.sourceforge.net>
Message-ID: <CAHC9VhQaCFirdVRBnd9UsbHZzdmfrEc5ZtzzSvru7uXqCeLL8Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:38 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:28:02 +0100
>
> Call the function "kfree" at the end only after it was determined
> that the passed parameter contained a non-null pointer.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index faa6ecc2450d..88730b372277 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -620,8 +620,8 @@ static int common_destroy(void *key, void *datum, void *p)
>                 comdatum = datum;
>                 hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
>                 hashtab_destroy(comdatum->permissions.table);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }

I'm dropping this patch because it really doesn't do much other than
add some code churn.  I suppose you can argue it removes one
conditional if datum is NULL, but that is such a corner case I'm not
worried about it.

If I were to merge this, I would probably expect "kfree(datum)" to be
converted to "kfree(comdatum)" (and similar in the cases below).

> @@ -675,8 +675,8 @@ static int cls_destroy(void *key, void *datum, void *p)
>                         kfree(ctemp);
>                 }
>                 kfree(cladatum->comkey);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }
>
> @@ -689,8 +689,8 @@ static int role_destroy(void *key, void *datum, void *p)
>                 role = datum;
>                 ebitmap_destroy(&role->dominates);
>                 ebitmap_destroy(&role->types);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }
>
> @@ -712,8 +712,8 @@ static int user_destroy(void *key, void *datum, void *p)
>                 ebitmap_destroy(&usrdatum->range.level[0].cat);
>                 ebitmap_destroy(&usrdatum->range.level[1].cat);
>                 ebitmap_destroy(&usrdatum->dfltlevel.cat);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }
>
> @@ -726,8 +726,8 @@ static int sens_destroy(void *key, void *datum, void *p)
>                 levdatum = datum;
>                 ebitmap_destroy(&levdatum->level->cat);
>                 kfree(levdatum->level);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
